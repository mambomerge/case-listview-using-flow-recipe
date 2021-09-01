public class LightningController {
	@auraEnabled
    public static List<Case> queryCases(List<String> ids){
        List<Case> results = new List<Case>();
        List<String> fieldsList = new List<String>();
        Map<String, Schema.SObjectField> fieldMap = Case.getSobjectType().getDescribe().fields.getMap();
        for (String f : fieldMap.keySet()) {
            Schema.DescribeFieldResult dfr = fieldMap.get(f).getDescribe();
            String fieldName = dfr.getLocalName();
            if ( dfr.isAccessible() && !dfr.isQueryByDistance() ) {
                if (
                    (dfr.getType() == Schema.DisplayType.Currency ||
                     dfr.getType() == Schema.DisplayType.Double ||
                     dfr.getType() == Schema.DisplayType.Integer ||
                     dfr.getType() == Schema.DisplayType.Date ||
                     dfr.getType() == Schema.DisplayType.DateTime)
                ) {
                    fieldsList.add('FORMAT(' + fieldName + ')');
                } else {
                    fieldsList.add(fieldName);
                }
            }
        }
        String queryString = 'SELECT ' +
            String.join(fieldsList, ',') +
            ' FROM Case' +
            ' WHERE ' +
            ' Id IN :ids';
        results = database.query(queryString);
        return results;
    }
}
