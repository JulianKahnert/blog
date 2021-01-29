---
title: PDF Archiver
description: A tool for tagging files and archiving tasks.
tags: pdfarchiver
---

Let's be honest: sorting documents is painful, no matter if you try it with analogue folders or digitally on your computer.<br>
Putting letters in different filing folders might help you to find your documents if needed. But it is a time consuming process, which ended (in my case) in a huge amount of unsorted letters on my desk.


## New Archiving Approach
Last year I started with a new approach.
I talked to some friends about a structure which could handle files longterm.
We found [this blog post](http://karl-voit.at/managing-digital-photographs/) by [Karl Voit](http://karl-voit.at) and came up with the following two *requirements*:

* Longterm archiving
* Fast way to find the documents, e.g. with a clean name structure

Both will be discussed in the following sections.

### Longterm Archiving
If I have to tag all the old files manually, it will take some time and I don't want to do this more than one time.
So at first we dismissed the thought about storing all files with the help of one specific app.
We still want to access our documents if a developer stops supporting his app.<br>
With that in mind, we thought that plain files on a hard drive seemed to be a good fit.
The file format was an obvious choice: [PDF](https://en.wikipedia.org/wiki/Portable_Document_Format) (or [PDF/A](https://en.wikipedia.org/wiki/PDF/A)) files are standarized and exist for quite a while already.<br>
While beeing geeks, searching via a terminal was a no-brainer.
Furthermore we wanted to put all the necessary information into the filename.
This keeps us independent of the current operating/file system and lets us easily backup the whole archive to another machine.

### Finding Documents
With this fixed we create a filename from the following three document attributes:

* **Date:** `yyyy-mm-dd` Date of the document content.
* **Description:** `--ikea-tradfri-gateway` Meaningful description of the document.
* **Tags:** `__bill_ikea_iot` Tags which will help you to find the document in your archive.

Furthermore we came to the conclusion that we have to remove capital letters, spaces and language specific characters (such as `ä, ö, ü, ß`).
This helps to maximize the filesystem compatibility.
Finally, the archive looks like this:

```
.
└── Archive
    ├── 2017
    │   ├── 2017-05-12--apple-macbook__apple_bill.pdf
    │   └── 2017-01-02--this-is-a-document__bill_vacation.pdf
    └── 2018
        ├── 2018-04-30--this-might-be-important__work_travel.pdf
        ├── 2018-05-26--parov-stelar__concert_ticket.pdf
        └── 2018-12-01--master-thesis__finally_longterm_university.pdf
```

This structure accomplishes our needs and makes it very easy to search files ...

* ... by tag via a searchterm like: `_tagname`, starting with `_`
* ... by description via a searchterm like: `-descriptionword`, starting with `-`
* ... by tag or description via a searchterm like: `searchword`,  starting with the term

Moreover the file content can be searched, if the PDF files contain a text layer, which can be done with [OCR](https://en.wikipedia.org/wiki/Optical_character_recognition).

## My Workflow

### Scanning
With all these archive parameters set up, I started creating a workflow.
I scanned all the old letters, bills etc. which was really time consuming.
Afterwards I stacked the paper documents chronologically.
One filing folder for each year.
New incoming documents will be scanned and stored in a box.
Only very important certificates get stored separately.

Now you might think: *Well, is it really faster to scan the documents and tag them afterwards instead of sorting them right away?*<br>
The answer in my case: **Yes, definitely!**
As you are reading this I assume you are a tech person, which leads you to spend more time on your computer than in front of your shelf with all the binders.<br>
By scanning a document and leaving it in a box afterwards, you shift them to a place, where you might spend some time.
In my case, I speed up the scanning process by using the [Scanbot App](https://scanbot.io/) which also extracts the text from my scans and saves it in the PDF (Pro Feature).

### Tagging
With the scanned documents on my computer, I first used a little python tool to tag them, which was *ok*.
But tabbing, tag autocompletion and other shortcuts seemed to be a better fit for this workflow.
That's why I started [**PDF Archiver**](https://github.com/JulianKahnert/PDF-Archiver).

<p align="center">
<a href="https://github.com/JulianKahnert/PDF-Archiver" target="itunes_store">
  <img src="/img/AppIcon.svg" width="100px">
</a>
</p>

It is an open source project, which helps to rename the scanned documents accordingly to the prior concept.
The app can be installed with the commands from the [installation section](https://github.com/JulianKahnert/PDF-Archiver#floppy_disk-installation) of the GitHub repository or be downloaded directly from the [Mac App Store](https://apps.apple.com/app/pdf-archiver/id1352719750).
In both cases: please talk to me about feature requests and/or general thoughts.
Send me a [mail](mailto:PDF-Archiver@juliankahnert.de) or create a [GitHub issue](https://github.com/JulianKahnert/PDF-Archiver/issues)!

## Benefits
This leads to the benefits of saving the files digitally:

* With all your documents on your computer, you can easily copy them.
Having tagged documents stored on your smartphone might get handy in the future.

* Furthermore you can create backups of all your documents.
Keep in mind that a [3-2-1 Backup Strategy](https://www.backblaze.com/blog/the-3-2-1-backup-strategy/) is a useful thing.
The archive should not be stored on only one disk!

* Besides the archive structure, the [PDF Archiver](https://github.com/JulianKahnert/PDF-Archiver) saves all tags as [macOS Finder Tags](https://support.apple.com/HT202754).
This becomes very handy in the Finder on macOS and the iCloud Drive app on iOS.

* Last but not least: old paper documents can be trashed easily after some years.
Just ditch the whole filing folder of e.g. the year 2001.
