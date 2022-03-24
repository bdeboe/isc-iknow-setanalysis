# iKnow Set Analysis demo

This simple app demonstrates sample use of the InterSystems' iKnow technology for grouping records based
on their contents, or more specifically the occurrence of selected entities and CRCs. It allows you to start from any
given iKnow domain (or a text column in a table from which it'll make on) and navigate the concepts inside.
Through the simple interface, you can then select entities whose presence defines an abstract category or
"set" and check how different sets overlap. 

Of course, this is just a demo that illustrates the bottom-up data-centric nature and not meant as a production 
app.

See also [this Developer Community article](https://community.intersystems.com/post/iknow-demo-apps-part-2-set-analysis-demo) on setting up and using this interface

### Setting up the demo

See the class reference for the `Setup()` method in `Demo.SetAnalysis.Utils`. It allows setting up the demo for any text column in a target table. 
Alternatively, to work with an existing iKnow domain, simply add the REST web app with the following command:

```ObjectScript
do ##class(Demo.SetAnalysis.Utils).CreateRestWebApp()
```


### Credits
This is a generic version of the original app built by Danny Wijnschenk & Alain Houf for the 2015 Global Summit academy "Making your Unstructured Data Work"
