-- Example Event Data for Testing
-- Copy this into the Import tab (/iml import) to test the addon

{
    eventId = "ev-test-123",
    eventName = "Naxxramas Week 12",
    eventDate = "2024-12-20",
    raidType = "NAXX",
    attendees = {
        {
            name = "Natolie",
            class = "WARRIOR",
            role = "Tank",
            srChoices = {
                {
                    itemName = "Dreadnaught Helmet",
                    itemId = 22418,
                    points = 25,
                    priority = 1,
                    fromPreviousWeek = false
                },
                {
                    itemName = "Dreadnaught Breastplate",
                    itemId = 22416,
                    points = 15,
                    priority = 2,
                    fromPreviousWeek = false
                }
            }
        },
        {
            name = "Cacille",
            class = "PRIEST",
            role = "Heal",
            srChoices = {
                {
                    itemName = "Frostfire Circlet",
                    itemId = 23062,
                    points = 41,
                    priority = 1,
                    fromPreviousWeek = true
                },
                {
                    itemName = "Burrower Bracers",
                    itemId = 23071,
                    points = 5,
                    priority = 2,
                    fromPreviousWeek = false
                }
            }
        },
        {
            name = "Keirino",
            class = "ROGUE",
            role = "MDPS",
            srChoices = {
                {
                    itemName = "Kiss of the Spider",
                    itemId = 22954,
                    points = 30,
                    priority = 1,
                    fromPreviousWeek = true
                },
                {
                    itemName = "The Hungering Cold",
                    itemId = 23577,
                    points = 10,
                    priority = 2,
                    fromPreviousWeek = false
                }
            }
        },
        {
            name = "Shookee",
            class = "MAGE",
            role = "RDPS",
            srChoices = {
                {
                    itemName = "Frostfire Robe",
                    itemId = 23061,
                    points = 18,
                    priority = 1,
                    fromPreviousWeek = false
                },
                {
                    itemName = "Warmth of Forgiveness",
                    itemId = 23070,
                    points = 12,
                    priority = 2,
                    fromPreviousWeek = false
                }
            }
        },
        {
            name = "Arakisae",
            class = "PALADIN",
            role = "Heal",
            srChoices = {
                {
                    itemName = "Redemption Headpiece",
                    itemId = 22428,
                    points = 22,
                    priority = 1,
                    fromPreviousWeek = false
                },
                {
                    itemName = "Redemption Tunic",
                    itemId = 22424,
                    points = 8,
                    priority = 2,
                    fromPreviousWeek = false
                }
            }
        }
    }
}
