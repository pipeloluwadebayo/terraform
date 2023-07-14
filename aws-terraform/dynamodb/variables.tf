variable "fulltime_employees" {
  description = "Name the table that fulltime employee data"
  default     = "fulltime_employee"

}


variable "table_billing_mode" {
  description = "Control charges and manage capacity."
  default     = "PAY_PER_REQUEST"
}


variable "internal_inventory_table" {
  description = "Table referencing internal inventory records"
  default     = "internal_inventory"

}

