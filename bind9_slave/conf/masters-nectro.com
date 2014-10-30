masters "internalMasters.nectro.com" {
	192.168.1.101	key ns1-ns2.nectro.com.;
};

masters "externalMasters.nectro.com" {
	192.168.1.101	key ns1-ns2.nectro.com.;
};

