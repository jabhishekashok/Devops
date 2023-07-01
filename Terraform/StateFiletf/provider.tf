provider "local" {
  
}
resource "local_file" "test" {
  content  = "Hello World"
  filename = "C:/temp/test3.txt"
}