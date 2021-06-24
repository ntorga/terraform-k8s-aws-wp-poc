#
##
### Route 53
##
#
resource "aws_route53_zone" "dns-zone" {
  name = var.stage-domain[var.stage]
}

# BEGIN - Uncomment after first deploy
#resource "aws_route53_record" "main-record" {
#  zone_id = aws_route53_zone.dns-zone.zone_id
#  name    = "blog.${var.stage-domain[var.stage]}"
#  type    = "CNAME"
#  ttl     = "300"
#  records = [module.k8s.lb-hostname]
#}
# END - Uncomment after first deploy