# How to do some changes in each member of PDS?

For example we have some PDS with members like this:

<img width="470" height="150" src="./img/members-to-change.png">

And we need to change `CLASS=A` to `CLASS=E` in each of them.

<img width="470" height="250" src="./img/string-to-change.png">

From ISPF Primary Option Menu select **FMN** (File manager) and then **3.6**

Specify PDS and members:

<img width="470" height="300" src="./img/pds-to-change.png">

In the command line type: 
```
c 'CLASS=A' 'CLASS=E'
```

Press **Enter**. You will see all changes:

<img width="470" height="300" src="./img/changes.png">

Press **F3**

<img width="470" height="250" src="./img/save-changes.png">

Press **Enter** to complete

<img width="470" height="300" src="./img/saved.png">

The result:

<img width="470" height="250" src="./img/result.png">