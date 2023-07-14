resource "aws_dynamodb_table" "fulltime_employee" {
  name          = var.fulltime_employees
  hash_key      = "employee_id"
  contract_type = "fulltime"
  billing_mode  = var.table_billing_mode
  attribute {
    name = "employee_id"
    type = "N"
  }
}


resource "aws_dynamodb_table_item" "employee_items" {
  table_name = aws_dynamodb_table.employees.name
  hash_key   = aws_dynamodb_table.employees.hash_key
  item       = <<EOF
    {
        "Name": {"S": Pips}
        "Employee_id: {"N": "1901"}
        "Contract_type": {"S": Fulltime}
    }
    EOF
}




#inventory table
resource "aws_dynamodb_table" "inventory" {
  name         = var.internal_inventory_table
  billing_mode = var.table_billing_mode
  hash_key     = "AssetID"

  attribute {
    name = "AssetID"
    type = "N"
  }

  attribute {
    name = "AssetName"
    type = "S"
  }

  attribute {
    name = "Hardware"
    type = "B"
  }
  global_secondary_index {
    name            = "AssetName"
    hash_key        = "AssetName"
    projection_type = "ALL"

  }

  global_secondary_index {
    name            = "Hardware"
    hash_key        = "Hardware"
    projection_type = "ALL"

  }
}



resource "aws_dynamodb_table_item" "inventory_item" {
  table_name = aws_dynamodb_table.inventory.name
  hash_key   = aws_dynamodb_table.inventory.hash_key
  item       = <<EOF
 {
  "AssetID": {"N": "1"},
  "AssetName": {"S": "server"},
  "Hardware": {"B": "true" }
}
EOF
}
