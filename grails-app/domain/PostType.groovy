class PostType {

    static hasMany = [ posts : Post ]

    String name

    // like article post, activity post, activitytemplate post, etc.
    // comments to posts inherit their type

    static constraints = {
    }
}
