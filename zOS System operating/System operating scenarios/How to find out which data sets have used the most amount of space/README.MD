# How to find out which data sets have used the most amount of space?

Suppose you want to find large objects. We will do this in 2 ways:
- In standard ISPF Data Set List panel (displayed with ISPF option 3.4)
- Using the standard utility ISMF (Integrated Storage Management Facility)

With ISPF:

In ISPF DSLIST panel (in our example panel 'DSLIST - Data Sets Matching USCIT.USCFOC'), in ISPF command line
enter commend

sort tracks

??? Тут хотелось бы поместить screenshot ??? 

You will see all your USCIT.USCFOC...  datasets sorted descending by space allocated, together with percentage of currently used space in this allocation, and number of extents allocated for every displayed dataset.

??? Тут хотелось бы поместить screenshot ??? 

With ISMF:

1.	Open  ISMF 
2.	Select the "Data set" menu item

![ISMF interface](images/1.jpg)
 
3.	Here set the following parameters:
    * Data Set Name - **\*\***
    * Source of the new list – **1** (VTOC)
    * Storage Group Name – your Storage Group
    
![ISMF interface](images/2.jpg)
 
4.	Above, in the action bar, select List – 8 (Sort) 

![ISMF interface](images/3.jpg)
 
5.	Set the following parameters:
    * Major Field – **3** (Allocated space)
    * Major Field – **D** (In descending order)
    
![ISMF interface](images/4.jpg)
 
6.	You can now see the data sets that are consuming the most amount of space
