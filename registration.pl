#!/usr/bin/perl
use CGI ':standard';
if (param('username') eq ""||param('password') eq ""||param('password2') eq ""||param('fullname') eq "") 
{
	print "Content-type:text/html\n\n";
	print <<'EOF'
	
	<HTML>
<!-- START HEADER -->
<head>
<link rel="stylesheet" type="text/css" href="style.css">

	<title> Urban Groove Store - Registration </title>

	<center>
	<h1>URBAN GROOVE STORE</h1>
	<img src="uglogo.jpg" alt="Urban Groove Store" height="250" width="250">
	<div class="space"></div>
	<div id="umenu">
		<a href="index.html">HOME</a>
		<a href="catalogue.html">CATALOGUE</a>
		<a href="login.html">LOGIN</a>
	</div>
	<div class="space"></div>
	<div class="line"></div>


	</center>

</head>
<!--END HEADER-->
	<body>
	<h1> Please fill in ALL the required fields </h1>
	<p><a href="registration.html">Click here to try again</a></p> 
	</body>
	</HTML>
EOF

}
elsif (param('password') ne param('password2')) {
	print "Content-type:text/html\n\n";
	print <<'EOF'

	<HTML>
<!-- START HEADER -->
<head>
<link rel="stylesheet" type="text/css" href="style.css">

	<title> Urban Groove Store - RegistrationError </title>

	<center>
	<h1>URBAN GROOVE STORE</h1>
	<img src="uglogo.jpg" alt="Urban Groove Store" height="250" width="250">
	<div class="space"></div>
	<div id="umenu">
		<a href="index.html">HOME</a>
		<a href="catalogue.html">CATALOGUE</a>
		<a href="login.html">LOGIN</a>
	</div>
	<div class="space"></div>
	<div class="line"></div>


	</center>

</head>
<!--END HEADER-->
	<body>
	<h1> The passwords you have entered in do not match </h1>
	<p><a href="registration.html">Click here to try again</a></p>

	</body>
	<HTML>
EOF
} 
else {
	my $usrex = 0;
	my %users=(
		uname=>param('username'),
		fname=>param('fullname'),
		pword=>param('password')
		);
	
	open my $fpoint, "members.csv" or die $!;
	while(my $curr = <$fpoint>) {
		my @elements=split(',',$curr);

		if ($elements[0] eq $users{uname}) {
			$usrex = 1;
			}
		}
		if($usrex==1)
			{
			print "Content-type:text/html\n\n";
			print <<'EOF'
			<HTML>
<!-- START HEADER -->
<head>
<link rel="stylesheet" type="text/css" href="style.css">

	<title> Urban Groove Store - RegistrationError </title>

	<center>
	<h1>URBAN GROOVE STORE</h1>
	<img src="uglogo.jpg" alt="Urban Groove Store" height="250" width="250">
	<div class="space"></div>
	<div id="umenu">
		<a href="index.html">HOME</a>
		<a href="catalogue.html">CATALOGUE</a>
		<a href="login.html">LOGIN</a>
	</div>
	<div class="space"></div>
	<div class="line"></div>


	</center>

</head>
<!--END HEADER-->
			<body>
			<h1> This username has already been taken </h1>
			<p><a href="registration.html">Click here to try again</a></p>

			</body>
			</HTML>
EOF
			}
			
	
	if($usrex ==0)
{
	close $fpoint;
	open my $fh, ">>", "members.csv" or die $!;
	print $fh "$users{uname},";
	print $fh "$users{pword},";
	print $fh "$users{fname}\n";
			

	print "Content-type:text/html\n\n";
	print <<'EOF'
	<HTML>
<!-- START HEADER -->
<head>
<link rel="stylesheet" type="text/css" href="style.css">

	<title> Urban Groove Store - RegistrationSuccess </title>

	<center>
	<h1>URBAN GROOVE STORE</h1>
	<img src="uglogo.jpg" alt="Urban Groove Store" height="250" width="250">
	<div class="space"></div>
	<div id="umenu">
		<a href="index.html">HOME</a>
		<a href="catalogue.html">CATALOGUE</a>
		<a href="login.html">LOGIN</a>
	</div>
	<div class="space"></div>
	<div class="line"></div>


	</center>

</head>
<!--END HEADER-->
	<body>
	<h1> You have successfully registered </h1>
	<p><a href="login.html">Click here to login</a></p>

	</body>
	</HTML>	

EOF
}
}





