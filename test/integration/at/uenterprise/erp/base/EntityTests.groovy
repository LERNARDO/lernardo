package at.uenterprise.erp.base

import static org.junit.Assert.*
import org.junit.*
import groovy.sql.Sql
import at.uenterprise.erp.profiles.ParentProfile
import at.uenterprise.erp.Folder
import at.uenterprise.erp.FolderType
import at.uenterprise.erp.MetaDataService
import org.hibernate.SessionFactory

class EntityTests extends GroovyTestCase {

    Sql sql
    MetaDataService metaDataService
    EntityHelperService entityHelperService
    DefaultObjectService defaultObjectService
    SessionFactory sessionFactory

    @Before
    void setUp() {

        //defaultObjectService.onEmptyDatabase {
        //    metaDataService.initialize()
        //}

        Entity.withNewSession {session ->

            EntityType etParent = metaDataService.etParent

            Random generator = new Random()

            10.times {num ->
                entityHelperService.createEntityWithUserAndProfile("parent" + num, etParent, "parent" + num + "@domain.org", "parentFirstName parentLastName " + num) {Entity ent ->
                    ent.user.locale = new Locale("de", "DE")
                    ParentProfile prf = (ParentProfile) ent.profile
                    prf.firstName = "parentFirstName"
                    prf.lastName = "parentLastName"
                    prf.gender = generator.nextInt(2) + 1
                    prf.currentStreet = "dummyStreet"
                    prf.birthDate = new Date(generator.nextInt(20) + 60, generator.nextInt(12) + 1, generator.nextInt(28) + 1)
                    prf.maritalStatus = "dummyStatus"
                    prf.education = "dummyEducation"
                    prf.comment = "dummyComment"
                    prf.job = generator.nextBoolean()
                    if (prf.job) {
                        prf.addToJobtypes("dummyJob")
                        prf.jobIncome = generator.nextInt(150) + 50
                        prf.jobFrequency = "dummyFrequency"
                    }
                    prf.favoritesFolder = new Folder(name: "root", type: FolderType.findByName("favorite")).save(failOnError: true)
                }
            }
        }

        sql = new Sql(sessionFactory.currentSession.connection())
        sql.metaClass.getNumberOfSelects = {->
            delegate.
            return delegate.rows('select CURRENT_VALUE from information_schema.sequences'/*'SHOW STATUS LIKE "Com_select"'*/)/*[0].Value*/ as Long
        }
    }

    @After
    void tearDown() {
        // Tear down logic here
    }

    @Test
    void simpleTest() {
        Entity.list()
    }

    /*@Test
    void testSimpleQuery() {
        //get the current number of selects in this session
        def numberOfQueriesBeforeTest = sql.numberOfSelects

        //carry out the query
        final entity = Entity.list(max: 1) //1 query

        //now calculate the number of queries
        def numberOfQueriesAfterTest = sql.numberOfSelects
        final numberOfSelects = numberOfQueriesAfterTest - numberOfQueriesBeforeTest

        //is it what we expect??
        assert numberOfSelects == 1
    }

    @Test
    void testSimpleLazyPropertyAccess() {
        //get the current number of selects in this session
        def numberOfQueriesBeforeTest = sql.numberOfSelects

        //carry out the query
        final entity = Entity.list()[0] //1 query
        def fullName = entity.profile.fullName //1 query
        def email = entity.user.email //1 query

        //now calculate the number of queries
        def numberOfQueriesAfterTest = sql.numberOfSelects
        final numberOfSelects = numberOfQueriesAfterTest - numberOfQueriesBeforeTest

        //is it what we expect??
        assert numberOfSelects == 1
    }

    @Test
    void testSimpleEagerPropertyAccess() {
        //get the current number of selects in this session
        def numberOfQueriesBeforeTest = sql.numberOfSelects

        //carry out the query
        final entity = Entity.list([max: 1, fetch: [profile: 'join', 'user': 'join']])[0]//1 query
        def fullName = entity.profile.fullName //0 query
        def email = entity.user.email //0 query

        //now calculate the number of queries
        def numberOfQueriesAfterTest = sql.numberOfSelects
        final numberOfSelects = numberOfQueriesAfterTest - numberOfQueriesBeforeTest

        //is it what we expect??
        assert numberOfSelects == 1
    }*/
}
