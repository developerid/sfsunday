/*
 * GalaxyAddExtension
 * Override Galaxy New Button
 * Allow entry of a Galaxy along with a few stars
 */
public class GalaxyAddExtension {
    
    public Galaxy__c galaxy { get; set; }
    public List<Star__c> stars { get; set; }

    // Default number of stars to show
    private final Integer STAR_COUNT = 10;
        
	// Constructor - Initialize galaxy and stars
    public GalaxyAddExtension( ApexPages.StandardController controller) {
        galaxy = (Galaxy__c)controller.getRecord();
        stars = new List<Star__c>();
        for ( Integer i = 0 ; i < STAR_COUNT ; i++) {
            stars.add( new Star__c());
        }
        
    }
    
	// Save Method
    /*
     * The Save method will save any star with a name along with the Galaxy Id
     */
    public PageReference onSave() {
		// Don't save empty records
        if ( galaxy.Name == null ) {
            ApexPages.addMessage( new ApexPages.Message( ApexPages.Severity.ERROR, 'Galaxy Name is required'));
            return null;
        }
        insert galaxy;
        
		// Check for stars
        List<Star__c> goodStars = new List<Star__c>();
        for ( Star__c star : stars) {
            if ( star.Name != null ) {
                star.Galaxy__c = galaxy.Id;
                goodStars.add( star);
            }
        }
        insert goodStars;

		// Redirect to Galaxy View        
        return new PageReference( '/' + galaxy.Id);
    }

	// Cancel - Redirect to default Galaxy Page
    public PageReference onCancel() {
        return new PageReference( '/' + Galaxy__c.sObjectType.getDescribe().getKeyPrefix() + '/o');
    }
}