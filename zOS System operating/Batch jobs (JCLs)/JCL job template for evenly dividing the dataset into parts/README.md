# JCL job template for split a file in n files containing equal number of records

**This JCL job template allows to divide one large input dataset into a uniform subset of separate datasets.**

**JCL job link:** ссылка на гитхаб

**Be sure to change the following settings before starting the job:**
* `#INPUT DATASET#` - Input dataset that contains a large number of records
* `#OUT01,OUT02,...,OUTnn#` - How many datasets do you want to divide input dataset?
* `//OUT01 DD DSN=#Output file01#` - Output file01

  `//OUT02 DD DSN=#Output file02#` - Output file02
 
  `//* ...`
  
  `//OUTnn DD DSN=#Output filenn#` - Output filenn
* `IFTHEN=(WHEN=INIT,BUILD=(1:1,8,ZD,DIV,#Set number of divided datasets#,` - Set number of divided datasets