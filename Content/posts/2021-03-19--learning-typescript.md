---
date: 2021-02-23 00:00
title: Learning TypeScript
description: TODO
shouldSkip: true
tags: typescript, gettingstarted
---

[TS Handbook: Basic Types](https://www.typescriptlang.org/docs/handbook/2/basic-types.html)

### ECMAScript
> ECMAScript (or ES) is a general-purpose programming language, standardised by Ecma International according to the document ECMA-262. It is a JavaScript standard meant to ensure the interoperability of Web pages across different Web browsers. ECMAScript is commonly used for client-side scripting on the World Wide Web, and it is increasingly being used for writing server applications and services using Node.js.

[Wikipedia: ECMAScript](https://en.wikipedia.org/wiki/ECMAScript)

After some basic explanation of static typed languages we dive in (e.g. use) the TS compiler [tsc](https://www.typescriptlang.org/docs/handbook/2/basic-types.html#tsc-the-typescript-compiler).


## Tips and Tricks

> Rule of thumb: always use even node versions (8/10/12/14) as uneven are for dev only and never go in LTS

## Toolchain

### Node.js

> Node.js is an open-source, cross-platform, back-end JavaScript runtime environment that runs on the V8 engine and executes JavaScript code outside a web browser. Node.js lets developers use JavaScript to write command line tools and for server-side scripting—running scripts server-side to produce dynamic web page content before the page is sent to the user's web browser. Consequently, Node.js represents a "JavaScript everywhere" paradigm, unifying web-application development around a single programming language, rather than different languages for server-side and client-side scripts.
>
> Though .js is the standard filename extension for JavaScript code, the name "Node.js" doesn't refer to a particular file in this context and is merely the name of the product. Node.js has an event-driven architecture capable of asynchronous I/O. These design choices aim to optimize throughput and scalability in web applications with many input/output operations, as well as for real-time Web applications (e.g., real-time communication programs and browser games).

[Wikipedia: Node.js](https://en.wikipedia.org/wiki/Node.js)

https://nodejs.org/en/

### NPM

### NVM

[Version Manager for node.js](https://github.com/nvm-sh/nvm), designed to be installed per-user, and invoked per-shell.

```bash
$ nvm --help

...

Example:
  nvm install 8.0.0                     Install a specific version number
  nvm use 8.0                           Use the latest available 8.0.x release
  nvm run 6.10.3 app.js                 Run app.js using node 6.10.3
  nvm exec 4.8.3 node app.js            Run `node app.js` with the PATH pointing to node 4.8.3
  nvm alias default 8.1.0               Set default node version on a shell
  nvm alias default node                Always default to the latest available node version on a shell

  nvm install node                      Install the latest available version
  nvm use node                          Use the latest version
  nvm install --lts                     Install the latest LTS version
  nvm use --lts                         Use the latest LTS version
```


## Sources
* [TypeScript Website](https://www.typescriptlang.org)