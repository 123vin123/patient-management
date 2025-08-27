# Deployment Architecture README

## Overview

This project demonstrates a microservices-based deployment architecture leveraging AWS ECS, RDS, and MSK (Kafka). The architecture is designed for scalability, reliability, and efficient communication between services using gRPC and Kafka.

## Architecture Components

### 1. Frontend Client

* Communicates with the backend services via an Application Load Balancer (ALB).

### 2. Application Load Balancer (ALB)

* Public-facing entry point.
* Routes incoming requests to appropriate ECS services.

### 3. ECS Cluster

The ECS cluster hosts multiple services, each running as ECS tasks:

* **Auth Service**

  * Handles authentication and authorization.
  * Connects to **Auth Service DB** in RDS.

* **Billing Service**

  * Manages billing and payments.
  * Acts as a **gRPC Server** for inter-service communication.

* **API Gateway**

  * Entry point for client requests.
  * Routes requests to the appropriate microservices.

* **Patient Service**

  * Manages patient data.
  * Acts as a **gRPC Client** to Billing Service.
  * Publishes events to Kafka using a **Kafka Producer**.
  * Connects to **Patient Service DB** in RDS.

* **Analytics Service**

  * Consumes Kafka events for analytics and reporting.
  * Uses a **Kafka Consumer** to read from the Kafka topic.

### 4. Databases (RDS)

* **Auth Service DB**: Stores authentication and user-related information.
* **Patient Service DB**: Stores patient records and related data.

### 5. Kafka (MSK - Managed Streaming for Apache Kafka)

* Hosted in a private subnet for security.
* **Kafka Topic (patient)** stores patient-related events.
* Patient Service acts as a producer; Analytics Service acts as a consumer.

## Communication Flow

1. **Frontend Client** sends requests via **ALB**.
2. **API Gateway** routes requests to relevant ECS services.
3. **Billing Service** communicates with **Patient Service** via gRPC.
4. **Patient Service** publishes events to Kafka.
5. **Analytics Service** consumes patient events for reporting.
6. Auth and Patient services persist data to their respective **RDS databases**.

## Prerequisites

* AWS account with access to ECS, RDS, and MSK.
* Docker and AWS CLI configured locally.
* Terraform/CloudFormation (optional) for infrastructure provisioning.

## Deployment Steps

1. **Build Docker Images** for each service.
2. **Push Images** to Amazon ECR (Elastic Container Registry).
3. **Provision RDS** instances for Auth and Patient services.
4. **Setup MSK Cluster** and create `patient` topic.
5. **Create ECS Cluster** and deploy each service as an ECS task.
6. **Configure ALB** with listeners and target groups.
7. **Update Security Groups** to allow necessary communication between services.

## Future Enhancements

* Add CI/CD pipelines using AWS CodePipeline.
* Implement monitoring and alerting using CloudWatch.
* Enable autoscaling for ECS services.
* Add API authentication at the API Gateway level.

---

## For support, email vineetkumar.dev9@gmail.com or create an issue in this repository.
**Author**: Vineet Kumar

