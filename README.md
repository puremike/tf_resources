# Terraform Infrastructure as Code: Progressive Learning Project

This repository documents a structured, incremental learning path using Terraform to provision, configure, and manage AWS infrastructure efficiently and securely. The project covers fundamental Terraform concepts, resource creation, module development, state management, and integration with Terraform Cloud for remote state and workspace management.

---

## 🌟 What This Project Covers

| Category | Concepts & Resources |
|----------|---------------------|
| 🔧 **Basic Resources** | Lambda functions, RDS instances, IAM users and roles |
| 🔄 **State Management** | Local and remote backend configuration, state manipulation |
| 🗂️ **Modules** | Public and custom modules for reusable infrastructure patterns |
| 🔐 **Security & Identity** | Using AWS OIDC with Terraform Cloud for authentication |
| 📊 **Input & Output Handling** | Variables, locals, outputs, and object validation |
| 🌐 **Advanced Features** | Terraform Cloud workspace management, multi-resource coordination |
| 🏗️ **AWS Services** | S3 static website hosting, RDS database, IAM policies, Lambda |

---

## 🗂️ Folder & File Highlights

- `01-01proj-lambda-function/` — Creating and importing AWS Lambda resources
- `01-02proj-rds/` — Provisioning RDS MySQL/PostgreSQL instances with Terraform
- `01-03proj-oidc/` — Implementing AWS OIDC authentication with Terraform Cloud
- `09-public-modules/` & `10-my-modules/` — Developing and using reusable Terraform modules
- `11-state-manipulation/` — Manual state file management and manipulation
- `12-tf_workspace/` & `13-terraform-cloud/` — Using Terraform Cloud for remote state and workspace automation

---

## 📈 Project Significance

This incremental approach demonstrates a solid foundation in IaC best practices, starting from simple resource deployment to orchestrating complex, modular infrastructure. Integrating Terraform Cloud and AWS OIDC shows awareness of modern cloud security and collaboration workflows, which are critical in professional DevOps environments.

