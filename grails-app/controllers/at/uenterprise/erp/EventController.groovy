package at.uenterprise.erp

import java.text.SimpleDateFormat
import at.openfactory.ep.Entity

class EventController {

  /*
   * shows the events page
   */
  def index = {
    Entity entity = Entity.get(params.id)

    Calendar calendar = Calendar.getInstance()

    SimpleDateFormat tdf = new SimpleDateFormat("yyyy-MM-dd", new Locale("en"))

    List allEvents = Event.list([sort: 'dateCreated', order: 'desc'])

    List eventsToday = allEvents.findAll {tdf.format(it.date) == tdf.format(calendar.getTime())}

    calendar.add(Calendar.DATE, -1)
    List eventsYesterday = allEvents.findAll {tdf.format(it.date) == tdf.format(calendar.getTime())}

    calendar.add(Calendar.DATE, 2)
    List eventsTomorrow = allEvents.findAll {tdf.format(it.date) == tdf.format(calendar.getTime())}

    return ['entity': entity,
            'eventsToday': eventsToday,
            'eventsYesterday': eventsYesterday,
            'eventsTomorrow': eventsTomorrow]
  }
}
