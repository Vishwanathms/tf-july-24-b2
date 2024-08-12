step1 
1. download the terraform zip file
2. extract the file
3. copy the terraform.exe to an c:\bin( for example)
4. add the above path in the "environment"
5. Close the visual studio code and opne it and execute "terraform -version"

step2. 
1. create a folder to maint as repo , suggested in the repo folder which we used in git class
2. inside the folder , create an main.tf and add the content accordingly
3. run "terraform init" inside the above folder.


## list of components created

3 providers 
aws - 2
azure -- 1

one vpc in account1 
one vpc in account-2

one rg in azure subcription-1
one vnet in azure subcription-1

one of the vpc has been added with secondary cidr

the vnet is having multiple address space.

## terraform Features
* variables -- String 
* multi providers with alias names
* provide diff profiles names
* variable in tags
* 