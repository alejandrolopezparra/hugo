# www.alejandrolopezparra.es source code
Alejandro Lopez Parra's personal website is based on [*Hugo*](https://gohugo.io/), a popular open-source static site generators, and the [*Academic theme*](https://sourcethemes.com/academic/) for *Hugo*, a framework to help you create a beautiful website quickly.

A lot about them can be learnt by reading the [*Hugo* doc](https://gohugo.io/documentation/) and the [*Academic theme* doc](https://sourcethemes.com/academic/docs/). 

## Install
You can easily create your own website using mine:
1. Download and install ***Hugo***
   * https://gohugo.io/getting-started/installing/
2. Download and install ***Git***
   * https://git-scm.com/downloads
3. Clone my website source code from ***GitHub***:
   ```bash
   $# git clone https://github.com/alejandrolopezparra/hugo.git your_website_name
   ```
4. Clone official ***Academic theme*** from ***GitHub***:
   ```bash
   $# cd your_website_name
   $# git submodule update --init themes/academic/
   ```
5. Create your own posts
   * Remove my *.md* files (except *_index.md*) and add yours in *content/posts/* folder
6. Create your own talks
   * Remove my *.md* files (except *_index.md*) and add yours in *content/talks/* folder
7. Customize your new website
   * Modify *config.toml* file by tuning, at least, the following keys:
     * Global attributes
       * *baseurl = ""*
       * *title = ""*
       * *copyright = ""*
       * *googleAnalytics = ""*
     * *[params]* attributes
       * *role = ""*
       * *organizations = ""*
       * *avatar = ""*
     *  *[[params.social]]* attributes
   * Enable|Disable widgets in *content/home/* folder by setting attribute
     * *active = true|false*
8. Build your website into the *public* folder
   ```bash
   $# hugo
   ```
9. Upload your own static website, which is into the *public* folder, to wherever you want
   * [*GitHub Pages* guide](https://www.alejandrolopezparra.es/post/github_pages/) (in Spanish)
   * [*Amazon S3* guide](https://www.alejandrolopezparra.es/post/amazon_s3/) (in Spanish)
