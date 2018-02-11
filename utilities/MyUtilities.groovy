package utilities

class MyUtilities {
    static void addMyFeature(def job) {
        job.with {
            description('Arbitrary feature')
        }
    }
}