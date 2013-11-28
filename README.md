What is this?
-----

This is my attempt in creating an iOS SDK for interacting with OData services.


I've heard OData is bad, why use it?
-----

OData has been widely criticized in the developer community. I plan to write more on this topic, but I basically agree that [most common criticisms pertain to a specific Micorosoft implementation](http://roysvork.wordpress.com/2013/06/24/is-using-odataiqueryable-in-your-web-api-an-inherently-bad-thing/) that makes it too easy to create 'unclean' web services (for example, whose model is tightly coupled with underlying database implementation). While those criticisms of the implementation are reasonable, those shortcoming are not of the protocol specification itself.

In my opinion, the protocol has many strong features, while not as badly designed as some people think. For example, you have access to the service model document. It's in EDMX, which is easy to parse.


But doesn't only Microsoft use OData?
-----

In most developer's minds OData is strongly connected to Microsoft's ASP.NET; it is less known that SAP has also chosen OData as the preferred protocol for Netweaver Gateway, that is, technology to communicate with SAP's systems. In fact, OData technical group [basically consists of MS and SAP guys](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=odata#officers).

The most recent releases of SAP Netweaver have Gateway pre-installed. While it's not heavily marketed (and consequently not everyone in SAP developer circles is aware of this), I think this connectivity presents an interesting opportunity for creating new applications that work with SAP systems.

The Gateway's server-side implementation of OData also significantly differs from those on Miscrosoft side. The platform helps with implementing protocol's features, but require most of the work to be done by developer itself. As a result, the OData service implemented on Gateway is likely to support only part of OData protocol, but will implement it in the manner controlled by developer.


Ok, but aren't there a lot of OData client SDKs?
-----

Yes, there are quite a few well-maintained libraries on Microsoft's or Android stack (e.g. [ODataJClient](https://github.com/MSOpenTech/ODataJClient)).

But no such luck on iOS side! The [official iOS library page](http://www.odata.org/libraries/ios/) lists a grand total of **two** libraries. The first one, [odata4objc](http://odataobjc.codeplex.com/SourceControl/latest) had no commits for two years (with 'support for iOS5', 'support for OData v3' and 'not feel like a .Net library' being unresolved open issues), and the project leadership just recently was, er,

> looking for new people, like yourself, to reorganize the project.

before [admitting on GitHub page the obvious truth in November](https://github.com/OData/odata4objc):

> This project is no longer active

The second library on that *iOS client library page*, [JayData](http://jaydata.codeplex.com/releases/view/113789) is actually a *JavaScript* library that somebody had bravely added, despite it, being, well, not exactly suitable for native iOS development.


There must exist some Microsoft and SAP's official implementations!
-----

Well, those companies promote OData protocol and they also happen to have a ton of bright people who are definitely able to create an amazing kick-ass library *in any language*. But it doesn't seem like anyone in those companies actually is paid for creating what I want, *a modern iOS native library*.

Materials from Microsoft recommending an iOS client library [seem to come from 2011](http://msdn.microsoft.com/en-us/data/gg602479.aspx) and happen to recommend the same odata4objc library. Well, we known how that turned out.

SAP sells a mobile access stack called SUP, which includes an iOS SDK, and throws in an SDK with SAP Netweaver Gateway as well. Those SDKs don't seem to be originally developed at SAP and that shows. They are also not open-source, and overall come from dark ages of iOS development. I don't think I feel comfortable shipping an application based on those.

(As an aside, [their mobile *JavaScript* library](https://sapui5.hana.ondemand.com/sdk/) is in much better shape).

Anyway, there probably are some people who are fine with those SDKs and they will not be interested in my project.


Folder Structure
-----

Together, folders that are alphabetically before `Examples` contain code for the OData library; its dependencies are Foundation framework and some CocoaPods. 

`ExplorerUI` contains classes for the ODExplorer App; its dependencies are library and UIKit.

`Library` and `Result` contain project files and auxililary resources for the library and the app respectively.

