# JCL job template for split a file in n files containing equal number of records

**This JCL job template allows to divide one large input dataset into a uniform subset of separate datasets.**

**JCL job link:** https://git.icdc.io/global-repository-for-mainframe-developers/zos-system-operating/-/blob/master/zOS%20utilities/JCL%20job%20template%20for%20evenly%20dividing%20the%20dataset%20into%20parts/JCL%20job%20template%20for%20split%20a%20dataset%20in%20n%20datasets%20containing%20equal%20number%20of%20records

**Be sure to change the following settings before starting the job:**
* `#INPUT DATASET#` - Input dataset that contains a large number of records
* `#OUT01,OUT02,...,OUTnn#` - How many datasets do you want to divide input dataset?
* `//OUT01 DD DSN=#Output file01#` - Output file01

  `//OUT02 DD DSN=#Output file02#` - Output file02
 
  `//* ...`
  
  `//OUTnn DD DSN=#Output filenn#` - Output filenn
* `IFTHEN=(WHEN=INIT,BUILD=(1:1,8,ZD,DIV,#Set number of divided datasets#,` - Set number of divided datasets