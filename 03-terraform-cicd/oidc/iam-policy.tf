# Permissions used by GitHub Actions to run Terraform
data "aws_iam_policy_document" "github_actions_permissions" {

  # Allow Terraform to locate the Project 2 state file
  statement {
    sid    = "TerraformStateBucketAccess"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::pwabuthu-terraform-state"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:prefix"

      values = [
        "security-monitoring/terraform.tfstate"
      ]
    }
  }

  # Allow Terraform to read and update Project 2 state
  statement {
    sid    = "TerraformStateObjectAccess"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::pwabuthu-terraform-state/security-monitoring/terraform.tfstate"
    ]
  }

  # Allow Terraform to lock state while an operation is running
  statement {
    sid    = "TerraformStateLockAccess"
    effect = "Allow"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]

    resources = [
      "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/terraform-state-locks"
    ]
  }


  # Manage Project 2 logging buckets
  statement {
    sid    = "SecurityMonitoringS3BucketManagement"
    effect = "Allow"

    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicy",
      "s3:PutBucketPolicy",
      "s3:DeleteBucketPolicy",
      "s3:GetBucketPublicAccessBlock",
      "s3:PutBucketPublicAccessBlock",
      "s3:DeleteBucketPublicAccessBlock",
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning",
      "s3:GetEncryptionConfiguration",
      "s3:PutEncryptionConfiguration",
      "s3:DeleteBucketEncryption",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.project_name}-cloudtrail-logs-*",
      "arn:aws:s3:::${var.project_name}-config-logs-*"
    ]
  }

  # Manage the Project 2 CloudTrail trail
  statement {
    sid    = "SecurityMonitoringCloudTrailManagement"
    effect = "Allow"

    actions = [
      "cloudtrail:CreateTrail",
      "cloudtrail:UpdateTrail",
      "cloudtrail:DeleteTrail",
      "cloudtrail:GetTrail",
      "cloudtrail:GetTrailStatus",
      "cloudtrail:StartLogging",
      "cloudtrail:StopLogging",
      "cloudtrail:ListTags",
      "cloudtrail:AddTags",
      "cloudtrail:RemoveTags"
    ]

    resources = [
      "arn:aws:cloudtrail:us-east-1:${data.aws_caller_identity.current.account_id}:trail/${var.project_name}-trail"
    ]
  }

  # Manage the Project 2 GuardDuty detector
  statement {
    sid    = "SecurityMonitoringGuardDutyManagement"
    effect = "Allow"

    actions = [
      "guardduty:CreateDetector",
      "guardduty:GetDetector",
      "guardduty:UpdateDetector",
      "guardduty:DeleteDetector",
      "guardduty:ListTagsForResource",
      "guardduty:TagResource",
      "guardduty:UntagResource"
    ]

    resources = ["*"]
  }

  # Manage the Project 2 SNS security alerts topic
  statement {
    sid    = "SecurityMonitoringSNSManagement"
    effect = "Allow"

    actions = [
      "sns:CreateTopic",
      "sns:DeleteTopic",
      "sns:GetTopicAttributes",
      "sns:SetTopicAttributes",
      "sns:ListTagsForResource",
      "sns:TagResource",
      "sns:UntagResource",
      "sns:Subscribe",
      "sns:Unsubscribe"
    ]

    resources = [
      "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:${var.project_name}-security-alerts"
    ]
  }

  # Manage the Project 2 EventBridge rule and target
  statement {
    sid    = "SecurityMonitoringEventBridgeManagement"
    effect = "Allow"

    actions = [
      "events:PutRule",
      "events:DeleteRule",
      "events:DescribeRule",
      "events:PutTargets",
      "events:RemoveTargets",
      "events:ListTargetsByRule",
      "events:ListTagsForResource",
      "events:TagResource",
      "events:UntagResource"
    ]

    resources = [
      "arn:aws:events:us-east-1:${data.aws_caller_identity.current.account_id}:rule/${var.project_name}-guardduty-findings"
    ]
  }

  # Manage AWS Config resources for Project 2
  statement {
    sid    = "SecurityMonitoringConfigManagement"
    effect = "Allow"

    actions = [
      "config:PutConfigurationRecorder",
      "config:DeleteConfigurationRecorder",
      "config:DescribeConfigurationRecorders",
      "config:StartConfigurationRecorder",
      "config:StopConfigurationRecorder",

      "config:PutDeliveryChannel",
      "config:DeleteDeliveryChannel",
      "config:DescribeDeliveryChannels",

      "config:PutConfigRule",
      "config:DeleteConfigRule",
      "config:DescribeConfigRules",

      "config:ListTagsForResource",
      "config:TagResource",
      "config:UntagResource"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "SecurityMonitoringConfigRoleManagement"
    effect = "Allow"

    actions = [
      "iam:CreateRole",
      "iam:GetRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:DeleteRole",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:ListAttachedRolePolicies"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project_name}-config-role"
    ]
  }

  statement {
    sid    = "AllowPassRoleToAWSConfig"
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project_name}-config-role"
    ]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["config.amazonaws.com"]
    }
  }
}

# Create the IAM policy
resource "aws_iam_policy" "github_actions_terraform" {
  name        = "github-actions-terraform-policy"
  description = "Permissions for GitHub Actions to deploy the AWS security monitoring Terraform stack"

  policy = data.aws_iam_policy_document.github_actions_permissions.json
}

# Attach the permissions policy to the OIDC role
resource "aws_iam_role_policy_attachment" "github_actions_terraform" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_actions_terraform.arn
}
