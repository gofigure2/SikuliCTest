def setUp(self):
	print "setUp";

def testFirefox(self):
	print "Click on firefox";
	click("1308851838899.png")
	doubleClick("1308852041788.png")
	type("http://midasjournal.org"+Key.ENTER)
	click("1308852315244.png")
	type("sikuli"+Key.ENTER)

def tearDown(self):
	print "tearDown";
