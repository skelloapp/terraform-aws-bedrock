#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "bedrock" {
  source = "../.." # local example
  create_agent_alias = true
  create_kb = false
  create_default_kb = false
  create_s3_data_source = false
  foundation_model = "anthropic.claude-3-5-sonnet-20241022-v2:0"
  instruction = "You are an agent. Do what the supervisor tells you to do"

  create_collaborator = true
  collaboration_instruction = "Tell the other agent what to do"
  supervisor_model = "anthropic.claude-3-5-sonnet-20241022-v2:0"
  supervisor_instruction = "You are a supervisor who can provide detailed information about cars to an agent."
}