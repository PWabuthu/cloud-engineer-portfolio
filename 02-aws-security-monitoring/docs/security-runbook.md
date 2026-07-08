# Security Monitoring Runbook

This runbook documents how I validated and would respond to findings in the AWS Security Monitoring Baseline project.

The project currently includes CloudTrail, GuardDuty, EventBridge, SNS, AWS Config, and secured S3 log buckets.

## What I Validated

I generated GuardDuty sample findings to test the alerting path.

The first version routed all GuardDuty findings to SNS. That confirmed the pipeline worked, but it also created too much email noise because every sample finding triggered an alert.

After that test, I disabled the EventBridge rule, removed the SNS email subscription, and updated the EventBridge event pattern to only route GuardDuty findings with severity greater than or equal to 4.

The current alerting path is:

**GuardDuty finding with severity >= 4 → EventBridge severity filter → SNS topic → email alert**

Low-severity findings are not emailed in this version. A stronger production version would route them to CloudWatch Logs or an S3 archive for later review instead of dropping them from the alerting path completely.

## Sample Finding Validation Notes

The GuardDuty sample findings helped confirm that the alerting pipeline worked end to end.

Sample findings are useful for testing routing and notification behavior, but they are not the same as real suspicious activity in the account. Sample findings do not generate real CloudTrail events, so I could not correlate them the way I would with an actual finding.

For a real GuardDuty finding, I would use CloudTrail to check the activity around the time of the finding and look for the IAM principal, API action, source IP, user agent, affected resource, and whether the call succeeded or failed.

## Severity Handling

For this project, I used the numeric GuardDuty severity value to decide what gets sent to email.

The EventBridge rule currently sends findings with severity greater than or equal to 4 to SNS. That means medium and higher severity findings are emailed.

I chose that threshold because the first test showed that sending every finding to email creates noise quickly. Low-severity findings may still matter, but I would rather route them to a quieter review location than send every low-severity item to email.

## EventBridge Rule Pattern

The EventBridge rule uses this severity filter:

- Source: `aws.guardduty`
- Detail type: `GuardDuty Finding`
- Severity filter: `numeric >= 4`

In Terraform, that filter is defined in the EventBridge event pattern under `detail.severity`.

This keeps the SNS email path focused on findings that need faster attention.

## Real Finding Triage Process

For a real GuardDuty finding, I would start by checking:

- Finding type
- Severity score
- Affected resource
- Region
- Time of detection
- IAM principal involved, if available
- Related CloudTrail activity
- Whether the activity was expected, accidental, or suspicious

The first question is not “how do I fix it?” The first question is whether the finding represents expected activity, a misconfiguration, or something that may be unauthorized.

## CloudTrail Review Process

CloudTrail is where I would confirm what actually happened around the time of a real finding.

I would check:

- Which principal made the API call
- What action was taken
- Whether the action succeeded or failed
- Source IP address
- User agent
- Affected AWS resource
- Nearby events from the same user, role, or IP address

CloudTrail is important because GuardDuty tells me something may be suspicious, but CloudTrail helps me reconstruct the activity behind it.

## AWS Config Review Process

AWS Config is used to check whether resources are configured against security expectations.

The current project includes these managed rules:

- `S3_BUCKET_PUBLIC_READ_PROHIBITED`
- `INCOMING_SSH_DISABLED`
- `ROOT_ACCOUNT_MFA_ENABLED`

These were chosen because they map to common beginner cloud security risks: public data exposure, open administrative access, and weak root account protection.

## Destroy / Cleanup Note

During cleanup, the CloudTrail and AWS Config S3 buckets could not be deleted at first because versioning was enabled and the buckets still had object versions inside them.

I had to remove the remaining object versions before Terraform could finish destroying the buckets.

That was a useful operations lesson: versioned S3 buckets can block Terraform destroy until all object versions and delete markers are removed.

## Current Limitations

This project does not yet route low-severity GuardDuty findings to a separate destination. Right now, the filter prevents them from reaching email, but a better design would still store them somewhere quieter, such as CloudWatch Logs or S3.

The project also does not include automated remediation yet. I wanted to understand the detection and triage path before adding automation that changes resources.

## Future Improvements

Future improvements could include:

- CloudWatch dashboard for security visibility
- CloudWatch metric filters for key security events
- Separate routing for low, medium, and high severity findings
- CloudWatch Logs or S3 archive for low-severity findings
- Automated remediation for specific low-risk issues
- Slack or ticketing integration for alerts
- Additional AWS Config rules
- Security Hub integration