//
// Module: tf_aws_sg/sg_storm
//
//

// Provider specific configs
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

// Security Group Resource for Module
resource "aws_security_group" "main_security_group" {
    name = "${var.security_group_name}"
    description = "Security Group ${var.security_group_name}"
    vpc_id = "${var.vpc_id}"

    // allows traffic from the SG itself for tcp
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        self = true
    }

    // allows traffic from the SG itself for udp
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "udp"
        self = true
    }

    // allow traffic for TCP 22 (SSH)
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }
    // allow traffic for TCP 8301 (consul)
    ingress {
        from_port = 8301
        to_port = 8301
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 8301 (consul)
    ingress {
        from_port = 8301
        to_port = 8301
        protocol = "udp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 6627 (Nimbus)
    ingress {
        from_port = 6627
        to_port = 6627
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 8080 (Storm UI)
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 6700-6703 (Supervisor)
    ingress {
        from_port = 6700
        to_port = 6706
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

  // wide-open egress locally and externally separate rules
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}
