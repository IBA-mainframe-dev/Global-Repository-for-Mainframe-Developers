# How to find out which data sets have used the most amount of space?

Suppose you want to find large objects. We will do this using the standard utility ISMF (Integrated Storage Management Facility)

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
 
6.	You can now see the data sets that are consuming the most amount of memory
