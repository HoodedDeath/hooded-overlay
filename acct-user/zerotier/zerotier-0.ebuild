EAPI=8

inherit acct-user

DESCRIPTION="User for ZeroTier"

ACCT_USER_ID=961
ACCT_USER_HOME=/var/lib/zerotier-one
ACCT_USER_GROUPS=( zerotier )

acct-user_add_deps
