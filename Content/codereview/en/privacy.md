---
date: 2026-11-10 00:00
title: Privacy
description: CodeReview
---

This privacy policy covers the CodeReview app for macOS. The website you are reading it on is covered by the [privacy policy of juliankahnert.de](/privacy/).

## Who is responsible

Julian Kahnert, Postfach 53 29, 26043 Oldenburg, Germany. All contact details are in the [imprint](/imprint/).

## Your code stays with you

CodeReview has no account, no tracking, no analytics and no crash reporting of its own. It sends nothing to me on its own. Its start screen can show a banner for another app, as described under "Kickstart Exchange banner" below.

When you review a working tree, CodeReview reads the repository on your Mac and makes no network connection. Your marks, your recent reviews and the app's settings are stored on your Mac. If you connect Claude Code to CodeReview, the two talk through a server the app runs on your Mac only (127.0.0.1), which no other computer can reach.

## Pull requests

To review a pull request, CodeReview talks to GitHub's API at api.github.com, with the access token you give it, and only with it. The token is stored in your Mac's keychain. If you take it from the GitHub CLI, the app asks `gh` for it once and stores a copy in the keychain.

Through this connection the app loads the pull requests you open or that are waiting for you, with their files, diffs and comments, and sends the comments and reviews you post. GitHub sees your IP address and the token, and handles both under GitHub's privacy statement. Nothing of this passes through me.

## Support mails

When you click the support address in Settings, or the offer to ask for a file type CodeReview does not color yet, the app opens an email to support@kahnert.me in your mail app. It fills in only the subject, which can name the file extension. Nothing is sent until you send that email yourself.

I use your email only to answer your request and to improve the app, and delete it when it is no longer needed for that. The legal basis is Art. 6 (1) (b) GDPR, and Art. 6 (1) (f) GDPR for improving the app.

## Kickstart Exchange banner

The app can show a banner for another app at the foot of the left column of its start screen. No other screen shows one. The banner comes from Kickstart Exchange, a service through which app developers show each other's apps. Kickstart Exchange chooses the app to show by the app it appears in, not by who you are; the banner does not track you or your device. In the App Store privacy label, the app declares two data types for the Kickstart SDK: Product Interaction and Advertising Data, both Usage Data. Neither is linked to your identity, and neither is used for tracking. Kickstart Exchange is operated by Hudson Heavy Industries Ltd, 37 Great Pulteney Street, Bath, BA2 4DA, United Kingdom (hello@kickstart.tools); its privacy policy is at https://exchange.kickstart.tools/privacy.

To load a banner, the app connects to api.kickstart.tools and sends:

- the app's key for Kickstart Exchange, its bundle identifier, its version and build number, and the version of the Kickstart SDK
- the platform, macOS
- the country of your App Store account
- Apple's signed record of this app's download from the App Store (the App Transaction), which Kickstart Exchange checks to confirm a genuine App Store installation. The record can contain stable values Apple uses to identify the purchase and to verify the device. According to Kickstart, it checks only whether the record comes from the App Store's production environment, then discards it without storing, logging or analyzing these values, and the app does not keep a copy.

The app asks for one banner per launch. It then loads the advertised app's icon from the address Kickstart Exchange sends with the banner. Once the banner has been visible for one second, the app reports that it was seen, at most once per launch. If you click the banner, the app reports the click to Kickstart Exchange and opens the advertised app in the App Store. If you report a banner, the app sends the banner's ID and the reason you picked. These connections use no cookies and no cache.

Kickstart Exchange keeps records of which banners were delivered, seen and clicked for about 30 days. According to Kickstart, these records identify no person and no device. As with any connection, Kickstart's servers see your IP address: Cloudflare, which delivers Kickstart Exchange's traffic, processes it to deliver the connection, and according to Kickstart, Kickstart Exchange neither stores it nor uses it to identify anyone. The legal basis for the banner is our legitimate interest in financing the free app by promoting other developers' apps without building a profile of you (Art. 6(1)(f) GDPR).

If the advertised app's developer has set this up, the App Store link carries Apple's campaign tokens. Apple may then show that developer privacy-protected campaign results, such as downloads and purchases, in App Store Connect; Kickstart Exchange does not receive them.

Details are in the [privacy notice of Kickstart Exchange](https://exchange.kickstart.tools/privacy).

## Apple

Apple distributes the app through the App Store. If you agreed to share analytics and crash data with app developers in your Mac's settings, Apple passes anonymized crash reports and usage statistics on to me. You can change this in System Settings → Privacy & Security → Analytics & Improvements.

## Your rights

You have the right to access, rectification, erasure, restriction of processing, data portability and objection under Art. 15 to 21 GDPR, and the right to lodge a complaint with a supervisory authority, for example the State Commissioner for Data Protection of Lower Saxony. Write to the address in the [imprint](/imprint/) for anything concerning your data.
