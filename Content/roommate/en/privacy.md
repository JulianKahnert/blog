---
date: 2026-10-19 00:00
title: Privacy
description: Roommate Albert
---

This privacy policy covers the Roommate Albert app. The website you are reading it on is covered by the [privacy policy of juliankahnert.de](/privacy/).

## Who is responsible

Julian Kahnert, Postfach 53 29, 26043 Oldenburg, Germany. All contact details are in the [imprint](/imprint/).

## Your data stays with you

Roommate Albert has no account, no tracking and no analytics. It sends nothing to me on its own. Until you buy a license, it shows a banner for another app, as described under "Kickstart Exchange banner" below. Your meters, readings, tariffs and the photos stored with your readings live in a database on your device. If you are signed in to iCloud, the app keeps them in sync across your devices, as described under "iCloud sync" below.

- **Photo library:** with your permission, the app looks through your photos for pictures of your meters. Recognizing a meter and reading its value happen on your device, with Apple's Vision framework and, where available, Apple's on-device language model. Photos are not uploaded for recognition. The app may also search for new photos in the background while your device is charging. If a photo is stored in iCloud Photos only, your device downloads it from Apple to read it, as the Photos app would.
- **Camera:** when you add a meter, you can take a photo of it so the app recognizes it in later photos. That photo is stored in the app's database.
- **Data of the previous version:** if an earlier version of Roommate Albert left data on your device, the app can import it after you confirm.

## iCloud sync

iCloud sync is on by default and works only when you are signed in to iCloud. The app then stores in your private iCloud database:

- meters, meter devices and registers
- readings and the photos stored with them
- reference photos of your meters
- tariffs and prices
- a marker for each library photo the app has already searched, so your other devices skip it

Suggestions you have not confirmed yet and the app's search cache stay on the device.

Your private iCloud database belongs to your Apple Account. Apple stores it under Apple's privacy policy; I have no access to it.

You can turn sync off in the app under Settings → iCloud Sync. Signing out of iCloud stops it too; the data on the device stays.

## Backups and exports

A backup or a ZIP export is created only when you ask for it, and it goes where you choose to save or share it. Your device's own backups, such as iCloud Backup, include the app's data; those are handled by Apple under Apple's privacy policy.

## Support mails

When you tap "Contact Support" or "Report Recognition Error", the app prepares an email to support@pdf-archiver.io in your mail app. Nothing is sent until you send that email yourself. It has a diagnostics report attached that contains:

- the app version, the device model, the operating system version, the languages set and the free storage
- the app's log, which can name your meters, serial numbers and read values
- the number of meters, readings and photos in the database, and its size

"Report Recognition Error" also attaches the photo of the reading, without its location and other metadata.

I use your email and its attachments only to answer your request and to improve the recognition, and delete them when they are no longer needed for that. The legal basis is Art. 6 (1) (b) GDPR, and Art. 6 (1) (f) GDPR for improving the app.

## Purchases

You can unlock Roommate Albert with an auto-renewing subscription or a one-time lifetime purchase. Payment runs through the App Store and is handled by Apple under Apple's privacy policy. I receive no payment details.

To decide what is unlocked, the app asks StoreKit on your device for your purchases and active subscriptions, and whether you bought the app back when it cost money. If you did, everything stays unlocked. This check happens on the device; the app sends its result to nobody.

You manage or cancel a subscription in the settings of your Apple Account.

## Kickstart Exchange banner

As long as you have no license, the app shows a banner for another app on top of the Meters and Review tabs. The banner comes from Kickstart Exchange, a service through which app developers show each other's apps. Kickstart Exchange chooses the app to show by the app it appears in, not by who you are; the banner does not track you or your device. TODO(owner): name the operator of Kickstart Exchange and their address, from https://exchange.kickstart.tools/privacy.

To load a banner, the app connects to api.kickstart.tools and sends:

- the app's key for Kickstart Exchange, its bundle identifier, its version and build number, and the version of the Kickstart SDK
- the kind of device, such as iPhone or iPad
- the country of your App Store account
- Apple's signed record of this app's download from the App Store (the App Transaction), which Kickstart Exchange checks to confirm a genuine App Store installation. According to Kickstart, it does not store, log or analyze this record, and the app does not keep a copy. TODO(owner): decide whether to list the fields of the App Transaction here.

The app asks for one banner per launch. It then loads the advertised app's icon from the address Kickstart Exchange sends with the banner. Once the banner has been visible for one second, the app reports that it was seen, at most once per launch. If you tap the banner, the app reports the tap to Kickstart Exchange and opens the advertised app in the App Store. If you report a banner, the app sends the banner's ID and the reason you picked. These connections use no cookies and no cache.

Kickstart Exchange keeps records of which banners were delivered, seen and tapped for about 30 days. According to Kickstart, these records identify no person and no device. As with any connection, Kickstart's servers see your IP address. TODO(owner): add how Kickstart Exchange handles IP addresses and the legal basis for the banner, from https://exchange.kickstart.tools/privacy.

If the advertised app's developer has set this up, the App Store link carries Apple's campaign tokens. Apple may then show that developer privacy-protected campaign results, such as downloads and purchases, in App Store Connect; Kickstart Exchange does not receive them.

Details are in the [privacy notice of Kickstart Exchange](https://exchange.kickstart.tools/privacy).

## Apple

Apple distributes the app through the App Store. If you agreed to share analytics and crash data with app developers in your device's settings, Apple passes anonymized crash reports and usage statistics on to me. You can change this in Settings → Privacy & Security → Analytics & Improvements.

## Your rights

You have the right to access, rectification, erasure, restriction of processing, data portability and objection under Art. 15 to 21 GDPR, and the right to lodge a complaint with a supervisory authority, for example the State Commissioner for Data Protection of Lower Saxony. Write to the address in the [imprint](/imprint/) for anything concerning your data.
