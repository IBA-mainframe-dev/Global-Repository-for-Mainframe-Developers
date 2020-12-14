# How to compare two data sets interactively?
It is possible to compare two non-VSAM datasets interactively. 

	1. Go to one of the datasets in `edit` or `view` mode
	2. Enter the command:
	
```
comp '#name of another dataset' excluded 
```

For instance, there are two datasets that differ in only one record.

<img align="right" width="330" src="images/compare-member2.png"/>

![member1](images/compare-member1.png)

Enter the command

![command](images/compare-command.png)

We get the result

![result](images/compare-result.png)