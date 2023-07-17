<?xml version="1.0"?>
<!-- DELL UltraSharp U3415W (rev A02) Monitor via DisplayPort -->
<monitor name="DELL U3415W (DisplayPort)" init="standard">
    <caps add="(prot(monitor)type(LCD)model(U3415)cmds(01 02 03 07 0C E3 F3)vcp(02 04 05 08 10 12 14(04 0B 05 06 08 09 0C) 16 18 1A 52 60(0F 10 11 12) AA(01 02 04) 62 AC AE B2 B6 C6 C8 C9 D6(01 04 05) DC(00 02 03 05) DF E0 E1 E2(00 01 02 04 14 19 0C 0D 0F 10 11 13) E4(00 01) F0(00 08) F1(01 02) F2 FD)mswhql(1)asset_eep(40)mccs_ver(2.1))"/>

    <!-- Vendor-specific controls for the DELL monitor -->
	<controls>
		<control id="defaults" address="0x04" delay="2000"/>
		<control id="defaultluma" address="0x05" delay="2000"/>
		<control id="defaultgeom" address="0x06" delay="2000"/>
		<control id="defaultcolor" address="0x08" delay="2000"/>

		<control id="brightness" address="0x10"/>
		<control id="contrast" address="0x12"/>

		<control id="red" address="0x16"/>
		<control id="green" address="0x18"/>
		<control id="blue" address="0x1A"/>

		<control id="redblack" address="0x6c"/>
		<control id="greenblack" address="0x6e"/>
		<control id="blueblack" address="0x70"/>

		<control id="inputsource" type="list" address="0x60">
			<value id="dp" value="0x0f"/>
			<value id="mdp" value="0x10"/>
			<value id="hdmi" value="0x11"/>
			<value id="hdmi-mhl" value="0x12"/>
		</control>
        <control id="audiospeakervolume" address="0x62"/>
        
        <control id="osdorientation" type="list" address="0xaa">
			<value id="landscape" value="0x01"/>
			<value id="portrait" value="0x02"/>
		</control>

		<control id="dpms" address="0xd6">
			<value id="on" value="1"/>
			<value id="standby" value="4"/>
			<value id="off" value="5"/>
		</control>

		<control id="colorpreset" address="0x14">
			<value id="5000k" value="0x04"/>
			<value id="6500k" value="0x05"/>
			<value id="7500k" value="0x06"/>
			<value id="9300k" value="0x08"/>
			<value id="10000k" value="0x09"/>
			<value id="user1" value="0x0B"/>
			<value id="user2" value="0x0C"/>
		</control>

		<control id="magicbright" address="0xdc">
			<value id="standard"  value="0x00"/>
			<value id="multimedia"  value="0x02"/>
			<value id="movie"  value="0x03"/>
			<value id="game" value="0x05"/>
		</control>

		<control id="power" type="list" address="0xe1">
			<value id="off" value="1"/>
			<value id="on"  value="0"/>
		</control>
	</controls>
    
</monitor>
