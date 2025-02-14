#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "bedrock" {
  source = "../.." # local example
  create_kb = true
  create_kendra_config = true
  create_agent = false
  foundation_model = "anthropic.claude-v2"
  instruction = "You are an automotive assisant who can provide detailed information about cars to a customer."
}