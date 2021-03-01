# How to create user in TEP?

1.	For the first start use **sysadmin** for **Logon ID** field:

<img src="./img/1-logon.png" width="380" height="300">

2.	Select **Administer Users**

<img src="./img/2-enterprise.png" width="500" height="200">

3.	Select row with **sysadmin** and press **Create Another user** 

<img src="./img/3-create-another-user.png" width="650" height="450">

4.	Insert **User ID** which you have for LPAR for z/OS and press **Find**

<img src="./img/4-specify-name.png" width="700" height="500">

5.	Select your UID from list and press OK. Change **User Name**.

<img src="./img/5-specify.png" width="650" height="300">

6.	Press OK. New user is created.

<img src="./img/6-is-created.png" width="700" height="250">

Now you can run TEP using `tso_userID`. Only with `tso_userID` you can create, delete and modify datasets from TEP.