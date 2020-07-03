# capture-pdf

A throwaway Docker image to capture a given URL as a PDF. Docker helps contain all the setup necessary, as opposed to using a local installation of Chrome/Puppeteer.

```sh
URL="https://nicholas.cloud/blog/hello-world/"
mkdir $HOME/captures
docker build --iidfile /tmp/capture-pdf-image.id https://github.com/nchlswhttkr/capture-pdf.git#main
docker run --rm -v $HOME/captures:/captures `cat /tmp/capture-pdf-image.id` $URL
ls $HOME/captures
# Hello World (nicholas.cloud).pdf
```