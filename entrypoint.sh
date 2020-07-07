#!/bin/bash

set -eu

echo "
const puppeteer = require('puppeteer')

async function run() {
    const browser = await puppeteer.launch({
        headless: true,
        args: ['--no-sandbox']
    })
    const page = await browser.newPage()
    await page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0) Gecko/20100101 Firefox/78.0')
    await page.goto('$1', {
        waitUntil: 'networkidle0'
    })

    const title = await page.title()
    const match = (await page.url()).match(/^https?:\/\/?(([a-z0-9-]+\.)+[a-z]+)/)
    let domain
    if (match === null) {
        throw new Error('Could not get domain')
    } else {
        domain = match[1]
    }

    await page.pdf({
        path: \`/captures/\${domain} \${title}.pdf\`,
        printBackground: true,
        format: 'A4',
        margin: {
            top: '5mm',
            bottom: '5mm'
        }
    })
    await browser.close()
}

run()
" | node --unhandled-rejections=strict
