use chrono::NaiveDate;

pub struct Tournament {
    pub name: String,        // "2026 FIFA World Cup"
    pub slogan: String,      // "We Are 26"
    pub start_date: NaiveDate,
    pub end_date: NaiveDate,
    pub hosts: Vec<String>,  // ["Canada", "Mexico", "United States"]
    pub teams_count: u32,    // 48
    pub confed_count: u32,   // 6
    pub venues_count: u32,   // 16
    pub host_cities_count: u32, // 16
}

pub struct GroupTeam {
    pub name: String,        // "Mexico"
    pub code: String,        // "MEX"
    pub is_host: bool,
    pub is_debut: bool,      // Cape Verde, Curaçao, Jordan, Uzbekistan
}

pub struct Group {
    pub name: String,        // "A" .. "L"
    pub note: Option<String>,// e.g. "Mexico opens tournament at Estadio Azteca"
    pub teams: Vec<GroupTeam>,
    pub first_match_date: NaiveDate,
}

pub struct RoundSchedule {
    pub round_name: String,  // "Group stage – Matchday 1"
    pub date_range: String,  // "June 11–17, 2026"
}

impl Tournament {
    pub fn sample() -> Self {
        Tournament {
            name: "2026 FIFA World Cup".to_string(),
            slogan: "We Are 26".to_string(),
            start_date: NaiveDate::from_ymd_opt(2026, 6, 11).unwrap(),
            end_date: NaiveDate::from_ymd_opt(2026, 7, 19).unwrap(),
            hosts: vec!["Canada".to_string(), "Mexico".to_string(), "United States".to_string()],
            teams_count: 48,
            confed_count: 6,
            venues_count: 16,
            host_cities_count: 16,
        }
    }
}

impl Group {
    pub fn sample_groups() -> Vec<Self> {
        vec![
            Group {
                name: "A".to_string(),
                note: Some("Mexico opens tournament at Estadio Azteca".to_string()),
                teams: vec![
                    GroupTeam {
                        name: "Mexico".to_string(),
                        code: "MEX".to_string(),
                        is_host: true,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "South Africa".to_string(),
                        code: "RSA".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Poland".to_string(),
                        code: "POL".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Saudi Arabia".to_string(),
                        code: "KSA".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                ],
                first_match_date: NaiveDate::from_ymd_opt(2026, 6, 11).unwrap(),
            },
            Group {
                name: "B".to_string(),
                note: Some("Canada opens in Toronto".to_string()),
                teams: vec![
                    GroupTeam {
                        name: "Canada".to_string(),
                        code: "CAN".to_string(),
                        is_host: true,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Argentina".to_string(),
                        code: "ARG".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Morocco".to_string(),
                        code: "MAR".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Peru".to_string(),
                        code: "PER".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                ],
                first_match_date: NaiveDate::from_ymd_opt(2026, 6, 12).unwrap(),
            },
            Group {
                name: "C".to_string(),
                note: None,
                teams: vec![
                    GroupTeam {
                        name: "England".to_string(),
                        code: "ENG".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Denmark".to_string(),
                        code: "DEN".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Slovenia".to_string(),
                        code: "SVN".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Serbia".to_string(),
                        code: "SRB".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                ],
                first_match_date: NaiveDate::from_ymd_opt(2026, 6, 13).unwrap(),
            },
            Group {
                name: "D".to_string(),
                note: Some("United States opens in Inglewood".to_string()),
                teams: vec![
                    GroupTeam {
                        name: "United States".to_string(),
                        code: "USA".to_string(),
                        is_host: true,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Wales".to_string(),
                        code: "WAL".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Panama".to_string(),
                        code: "PAN".to_string(),
                        is_host: false,
                        is_debut: false,
                    },
                    GroupTeam {
                        name: "Uzbekistan".to_string(),
                        code: "UZB".to_string(),
                        is_host: false,
                        is_debut: true, // Debutant
                    },
                ],
                first_match_date: NaiveDate::from_ymd_opt(2026, 6, 14).unwrap(),
            },
        ]
    }
}

impl RoundSchedule {
    pub fn sample_rounds() -> Vec<Self> {
        vec![
            RoundSchedule {
                round_name: "Group stage – Matchday 1".to_string(),
                date_range: "June 11–17, 2026".to_string(),
            },
            RoundSchedule {
                round_name: "Group stage – Matchday 2".to_string(),
                date_range: "June 18–24, 2026".to_string(),
            },
            RoundSchedule {
                round_name: "Group stage – Matchday 3".to_string(),
                date_range: "June 25–27, 2026".to_string(),
            },
            RoundSchedule {
                round_name: "Round of 32".to_string(),
                date_range: "June 29–July 2, 2026".to_string(),
            },
            RoundSchedule {
                round_name: "Round of 16".to_string(),
                date_range: "July 4–7, 2026".to_string(),
            },
            RoundSchedule {
                round_name: "Quarter-finals".to_string(),
                date_range: "July 9–11, 2026".to_string(),
            },
            RoundSchedule {
                round_name: "Semi-finals".to_string(),
                date_range: "July 14–15, 2026".to_string(),
            },
            RoundSchedule {
                round_name: "Third-place match".to_string(),
                date_range: "July 18, 2026".to_string(),
            },
            RoundSchedule {
                round_name: "Final".to_string(),
                date_range: "July 19, 2026".to_string(),
            },
        ]
    }
}