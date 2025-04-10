#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

# Supervisor agent
module "agent_supervisor" {
  source  = "../.."
  create_agent = false
  create_supervisor = true
  supervisor_model = "anthropic.claude-3-5-sonnet-20241022-v2:0"
  supervisor_instruction = "You are a supervisor who can provide detailed information about products to an agent."
}

# First collaborator agent
module "agent_collaborator1" {
  source  = "../.."
  create_agent_alias = true
  foundation_model = "anthropic.claude-v2"
  instruction = "You are an assistant who can provide detailed information about products to a customer."
  supervisor_id = module.agent_supervisor.supervisor_id
  create_collaborator = true
  collaborator_name = "AgentA"
  collaboration_instruction = "Handle customer inquiries"
  
  # Define multiple action groups with different names to test ordering stability
  action_group_list = [
    {
      action_group_name = "invoker"
      description = "Invoker action group"
      action_group_state = "ENABLED"
      action_group_executor = {
        custom_control = "RETURN_CONTROL"
      }
      function_schema = {
        functions = [
          {
            name = "invoke_action"
            description = "Invokes an action"
            parameters = {
              action_name = {
                type = "string"
                description = "Name of the action to invoke"
                required = true
              }
            }
          }
        ]
      }
    },
    {
      action_group_name = "scratchpad"
      description = "Scratchpad action group"
      action_group_state = "ENABLED"
      action_group_executor = {
        custom_control = "RETURN_CONTROL"
      }
      function_schema = {
        functions = [
          {
            name = "create_note"
            description = "Creates a new note"
            parameters = {
              content = {
                type = "string"
                description = "Content of the note"
                required = true
              }
            }
          }
        ]
      }
    }
  ]

  depends_on = [module.agent_supervisor]
}

# Second collaborator agent
module "agent_collaborator2" {
  source  = "../.."
  create_agent_alias = true
  foundation_model = "anthropic.claude-v2"
  instruction = "You are an assistant who can provide detailed information about products to a customer."
  supervisor_id = module.agent_supervisor.supervisor_id
  create_collaborator = true
  collaborator_name = "AgentB"
  collaboration_instruction = "Process backend tasks"
  
  # Define multiple action groups with different names to test ordering stability
  action_group_list = [
    {
      action_group_name = "invoker"
      description = "Invoker action group"
      action_group_state = "ENABLED"
      action_group_executor = {
        custom_control = "RETURN_CONTROL"
      }
      function_schema = {
        functions = [
          {
            name = "invoke_action"
            description = "Invokes an action"
            parameters = {
              action_name = {
                type = "string"
                description = "Name of the action to invoke"
                required = true
              }
            }
          }
        ]
      }
    },
    {
      action_group_name = "scratchpad"
      description = "Scratchpad action group"
      action_group_state = "ENABLED"
      action_group_executor = {
        custom_control = "RETURN_CONTROL"
      }
      function_schema = {
        functions = [
          {
            name = "create_note"
            description = "Creates a new note"
            parameters = {
              content = {
                type = "string"
                description = "Content of the note"
                required = true
              }
            }
          }
        ]
      }
    }
  ]

  depends_on = [module.agent_supervisor, module.agent_collaborator1]
}
