
provider "aws" {
  region = "us-east-1"
}

module "nuvuli_agent" {
  source = "../AWS/"

  api_endpoint = var.api_endpoint                  # URL to hit to talk to Nuvuli Cloud
  api_key = var.api_key                            # API key from the Nuvuli Cloud dashboard.  Keep this a secret.
  tenant_id = var.tenant_id                        # Tenant ID from the Nuvuli Cloud dashboard.
  schedule_id = var.schedule_id                    # Schedule ID from the Nuvuli Cloud dashboard.
  account_id = var.account_id                      # Cloud Account ID from the Nuvuli Cloud dashboard.

  schedule_name = "Dev Env"                        # display name in Nuvuli Cloud UI for this schedule
  matching_tags = "ReduceCloudCosts=Managed"       # list of tags to match and manage
  paused = true                                    # paused = true means that this schedule will NOT manage resources

  /*
   JSON formatted map of days and the hours you want resources to be OFF.


   Examples from below...

    "MON": "0-7,17-23"

   This means
    "Every monday, I want all my resources OFF between the hours of 00:00am GMT and 07:00am GMT inclusive
     then, and ome on at 08:00am GMT.  Additionally, I want all resources OFF between the hours of 17:00pm GMT
     and 23:00pm GMT inclusive."


    "SUN": "0-23"

   This means
    "Every Sunday, I want resources to be OFF every hour of the day.  Resources will not be ON at all."

  */
  schedule = <<EOT
  {
    "SUN": "0-23",
    "MON": "0-7,17-23",
    "TUE": "0-7,17-23",
    "WED": "0-7,17-23",
    "THU": "0-7,17-23",
    "FRI": "0-7,17-23",
    "SAT": "0-23"
  }
EOT
}

