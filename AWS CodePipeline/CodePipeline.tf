provider "aws" {
  region = "us-east-1"  # Update with your desired region
}

resource "aws_iam_role" "demo_pipeline_role" {
  name = "DemoPipelineRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "demo_pipeline_policy" {
  name        = "DemoPipelinePolicy"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::your-artifact-bucket/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticbeanstalk:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:CancelUploadArchive",
        "codecommit:GetBranch",
        "codecommit:GetCommit",
        "codecommit:GetUploadArchiveStatus",
        "codecommit:UploadArchive"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "demo_pipeline_policy_attachment" {
  role       = aws_iam_role.demo_pipeline_role.name
  policy_arn = aws_iam_policy.demo_pipeline_policy.arn
}

resource "aws_s3_bucket" "demo_artifact_bucket" {
  bucket = "your-artifact-bucket"  # Update with your desired artifact bucket name
  acl    = "private"
}

resource "aws_codepipeline" "demo_pipeline" {
  name     = "Demo_Pipeline"
  role_arn = aws_iam_role.demo_pipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.demo_artifact_bucket.bucket
  }

  stage {
    name = "Source"

    action {
      name            = "SourceAction"
      category        = "Source"
      owner           = "AWS"
      provider        = "CodeCommit"
      version         = "1"
      output_artifacts = ["SourceOutput"]

      configuration {
        RepositoryName = "Demo_1"
        BranchName     = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name            = "BuildAction"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]

      configuration {
        ProjectName = "your-codebuild-project"  # Update with your desired CodeBuild project name
      }
    }
  }

  stage {
    name = "DeployToProd"

    action {
      name            = "ManualApproval"
      category        = "Approval"
      owner           = "AWS"
      provider        = "Manual"
      version         = "1"
      input_artifacts = ["BuildOutput"]
    }

    action {
      name            = "DeployToProdBeanstalk"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "Beanstalk"
      version         = "1"
      input_artifacts = ["SourceOutput"]

      configuration {
        ApplicationName     = "your-elasticbeanstalk-application"  # Update with your desired Elastic Beanstalk application name
        EnvironmentName    = "prod"  # Update with your desired production environment name
        WaitForReadyAction = "true"
      }
    }
  }
}
