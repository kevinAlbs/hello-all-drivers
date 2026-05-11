use mongodb::event::{command::CommandEvent, EventHandler};

pub fn make_handler() -> Option<EventHandler<CommandEvent>> {
    if std::env::var("PRINT_MONGODB_COMMANDS").is_err() {
        return None;
    }
    Some(EventHandler::callback(|event| match event {
        CommandEvent::Started(e) => println!(">> {} {}", e.command_name, e.command),
        CommandEvent::Succeeded(e) => println!("<< {} {}", e.command_name, e.reply),
        _ => {}
    }))
}
