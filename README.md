What is this?
---

This is my attempt in creating an iOS SDK for interacting with OData services.


I've heard OData is bad, why use it?
---
OData has been widely criticized in the developer community. I plan to write more on this topic, but for now suffice to say that most common criticisms pertain to a specific implementation in Microsoft's universe that makes it too easy to create a web service whose model is tightly coupled with underlying database implementation. While such tight coupling is definitely not the right way to go, I don't consider this to be a shortcoming of the protocol specification itself.

In my opinion, the protocol has many strong features, while not as badly designed as some people think. For example, you have access to the service model document. It's in EDMX, which is easy to parse.


But doesn't only Microsoft use OData?
---

In most developer's minds OData is strongly connected to Microsoft Azure Marketplace; it is less known that SAP has also chosen OData as the preferred protocol for Netweaver Gateway, that is, technology to communicate with SAP's systems. In fact, OData technical group [basically consists of MS and SAP guys](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=odata#officers).

The most recent releases of SAP Netweaver have Gateway pre-installed. While it's not marketed heavily (so that not even everyone in SAP developer circles is aware of this), I think this connectivity presents an interesting opportunity for creating new applications that work with SAP systems.

The NW Gateway's server-side implementation of OData also significantly differs from those on Miscrosoft side. They help developer with implementing protocol's features, but require most of the work to be done by developer itself. As a result, the OData service implemented on Gateway is likely to support only part of OData protocol, but will support it in manner controlled by developer.

Ok, but I know there are lot of OData implementations
---

Yes, there are many OData libraries, and there are well-maintained libraries on Microsoft's or Android stack (e.g. [ODataJClient](https://github.com/MSOpenTech/ODataJClient).

But no such luck on iOS side! The [official iOS library page](http://www.odata.org/libraries/ios/) lists a grand total of **two** libraries. The first one, [odata4objc](http://odataobjc.codeplex.com/SourceControl/latest) had no commits for two years, and the project leadership just recently was, er,

> looking for new people, like yourself, to reorganize the project.

before finally [admitting on GitHub page the obvious truth](https://github.com/OData/odata4objc):

> This project is no longer active and was put into the Outercurve Project Archive on 26-09-2013

The second 'iOS' library, [JayData](http://jaydata.codeplex.com/releases/view/113789) is actually a *JavaScript* library that somebody had bravely added on *iOS client library* page. Thanks, but, uhm, how does that help with iOS development?

There must exist Microsoft and SAP's official implementations!
---
Well, those companies happened to promote OData protocol and they also have a ton of bright people who are definitely able to create an amazing kick-ass library *in any language*. But it doesn't seem anyone in those companies actually is paid for creating an iOS native library.

Materials from Microsoft recommending a native iOS library I found [came from 2011](http://msdn.microsoft.com/en-us/data/gg602479.aspx) and happen to recommend the same odata4objc library. Well, we known how that turned out.

SAP sells a mobile access stack called SUP, which includes an iOS SDK, and throws in an iOS SDK with SAP Netweaver Gateway as well. Those SDK don't seem to be originally developed at SAP and that shows. I don't think I feel comfortable shipping an application based on those libraries.

(As an aside, [their *JavaScript* library](https://sapui5.hana.ondemand.com/sdk/) is is much better shape).

Anyway, there probably are some people who are fine with those SDKs and they will not be interested in my project.

Folder Structure
---

Together, folders that are alphabetically before `Examples` contain code for the OData library; its dependencies are Foundation framework and some CocoaPods. 

`ExplorerUI` contains classes for the ODExplorer App; its dependencies are library and UIKit.

`Library` and `Result` contain project files and auxililary resources for the library and the app respectively.

The files `README.md` and `Workspace.xcworkspace` are exactly what they sound like.

