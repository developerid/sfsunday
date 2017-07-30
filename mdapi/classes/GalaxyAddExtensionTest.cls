/**
 * Created by mnorton on 10/19/16.
 */

@IsTest (SeeAllData=false)
private class GalaxyAddExtensionTest {

	// Test Adding a single Galaxy
	static testMethod void testGalaxyInsert() {
		// Arrange
		PageReference page = new PageReference( '/apex/GalaxyAdd');
		Test.setCurrentPage( page);

		// Act
		Test.startTest();
		Galaxy__c galaxy = new Galaxy__c();
		ApexPages.StandardController stdController = new ApexPages.StandardController(galaxy);
		GalaxyAddExtension extension = new GalaxyAddExtension( stdController);
		extension.galaxy.Name = 'The Test Galaxy';
		extension.onSave();
		Test.stopTest();

		// Assert
		List<Galaxy__c> galaxies = [select Id, Name
									  from Galaxy__c
									 where Name = 'The Test Galaxy'];
		System.assertEquals( 1, galaxies.size(), 'Galaxy did not get inserted');

	}

	// Test Adding 5 Stars to a Galaxy
	static testMethod void testGalaxyInsert5Stars() {
		// Arrange
		PageReference page = new PageReference( '/apex/GalaxyAdd');
		Test.setCurrentPage( page);

		// Act
		Test.startTest();
		Galaxy__c galaxy = new Galaxy__c();
		ApexPages.StandardController stdController = new ApexPages.StandardController(galaxy);
		GalaxyAddExtension extension = new GalaxyAddExtension( stdController);
		extension.galaxy.Name = 'The 5 Star Galaxy';
		extension.stars[0].Name = 'Star 0';
		extension.stars[1].Name = 'Star 1';
		extension.stars[2].Name = 'Star 2';
		extension.stars[3].Name = 'Star 3';
		extension.stars[4].Name = 'Star 4';
		extension.onSave();
		Test.stopTest();

		// Assert
		List<Star__c> stars = [select Id, Name
								 from Star__c
							    where Galaxy__r.Name = 'The 5 Star Galaxy'];
		System.assertEquals( 5, stars.size(), 'There should be 5 stars');

	}

	// Test Adding a single Galaxy with No Name
	static testMethod void testGalaxyInsertWithNoName() {
		// Arrange
		PageReference page = new PageReference( '/apex/GalaxyAdd');
		Test.setCurrentPage( page);

		// Act
		Test.startTest();
		Galaxy__c galaxy = new Galaxy__c();
		ApexPages.StandardController stdController = new ApexPages.StandardController(galaxy);
		GalaxyAddExtension extension = new GalaxyAddExtension( stdController);
		extension.onSave();
		Test.stopTest();

		// Assert
		List<Galaxy__c> galaxies = [select Id, Name
		from Galaxy__c];
		System.assertEquals( 0, galaxies.size(), 'Galaxy should not have been created');

	}

	// Test On Cancel
	static testMethod void testOnCancel() {
		// Arrange
		PageReference page = new PageReference( '/apex/GalaxyAdd');
		Test.setCurrentPage( page);

		// Act
		Test.startTest();
		Galaxy__c galaxy = new Galaxy__c();
		ApexPages.StandardController stdController = new ApexPages.StandardController(galaxy);
		GalaxyAddExtension extension = new GalaxyAddExtension( stdController);
		extension.galaxy.Name = 'Cancelled Galaxy';
		extension.stars[0].Name = 'Cancelled Star 0';
		extension.stars[1].Name = 'Cancelled Star 1';
		extension.stars[2].Name = 'Cancelled Star 2';
		extension.stars[3].Name = 'Cancelled Star 3';
		extension.stars[4].Name = 'Cancelled Star 4';
		extension.onCancel();
		Test.stopTest();

		// Assert
		List<Galaxy__c> galaxies = [select Id, Name from Galaxy__c];
		System.assertEquals( 0, galaxies.size(), 'Galaxy should not have been created');

	}


}