Daily Updates
------------------

### 22 June 2023
* Terraform
  * Vars
  * Varfiles
  * Tags
  * Stage File & Plan file using deployments

### 24 June 2023
* Terraform
  * Azure SQL deployment
      * azurerm_mssql_server
      * azurerm_mssql_database
          * server_id
          * sku_name
          * max_size_gb
  * `terraform show` command
  * `terraform plan` command
  *  **configuration drift**
     * difference between actual(state file) & desired(template file) state
     * its stored in **Plan** file

* 25 June 2023
    * Terraform
        * Azure SQL server/database

* 27 June 2023
    * Terraform
        * SQL Server/db
        * create VM
            * network interface
                * ip config
            * nic id
            * source image reference
    * Terraform Graph

* 30 June 2023
    * Data Source
    * Outputs
        * terraform output
    * terraform local providers
        * create file test.txt, then test1.txt & apply both times.
        * observe the plan => local file will be replaced
        * hence there will be a downtime.

* 1 July 2023
    * Terraform
        * State file activities
            * terraform state mv
            * terraform state list
            * terraform state show file.state
        * terraform backend
        * Terraform lock
        * Terraform Workspaces