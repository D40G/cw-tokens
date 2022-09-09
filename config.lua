Config = {}

Config.Debug = true

Config.Items = {
    empty = 'cw_token_empty',
    filled = 'cw_token'
}

Config.Tokens = {
    -- Raidjobs
    ['raidmeth'] = {
        value = 'raidmeth',
        label = 'Gives access to meth raid',
        price = 12000,
    },
    ['raidcocaine'] = {
        value = 'raidcocaine',
        label = 'Gives access to cocaine raid',
        price = 20000,
    },
    ['raidweed'] = {
        value = 'raidweed',
        label = 'Gives access to weed raid',
        price = 1000,
    },
    ['raidart'] = {
        value = 'raidart',
        label = 'Gives access to art raid',
        price = 35000,
    },
    -- boost
    ['boostelegyr'] = {
        value = 'boostelegyr',
        label = 'Gives access to Elegy Retro boost',
        price = 10000,
    },
    ['boostsultanrs'] = {
        value = 'boostsultanrs',
        label = 'Gives access to Sultan RS boost',
        price = 9000,
    },
    ['boostbanshee'] = {
        value = 'boostbanshee',
        label = 'Gives access to Banshee 900R boost',
        price = 11000,
    },
    ['boostvoodoo'] = {
        value = 'boostvoodoo',
        label = 'Gives access to voodoo Custom boost',
        price = 1000
    },
    -- trade
    ['tradeUzi'] = {
        value = 'tradeUzi',
        label = 'Gets you an uzi',
        price = 5000
    },
    ['tradeMilRifle'] = {
        value = 'tradeMilRifle',
        label = 'Gets you a military rifle',
        price = 30000
    },
}

Config.UseTrader = true
-- Trader
Config.Trader = {
    name = 'tokensGuy',
    model = 'ig_lifeinvad_01',
    tradeName = 'Tokens',
    coords = vector4(-1056.92, -247.32, 43.49, 42.99),
    animation = 'PROP_HUMAN_SEAT_CHAIR_DRINK',
}