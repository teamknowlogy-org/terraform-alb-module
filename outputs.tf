output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.alb.arn
}

output "alb_id" {
  description = "The ID of the ALB"
  value       = aws_lb.alb.id
}

output "alb_dns_name" {
  description = "The DNS Name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "alb_name" {
  description = "The name of the ALB"
  value       = aws_lb.alb.name
}

# output "listener_arn" {
#   description = "The ARN of the HTTPs Listener"
#   value       = aws_lb_listener.https_listener.arn
# }