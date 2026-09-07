---@diagnostic disable: undefined-global

-- atlases

SMODS.Atlas{
    key = 'Joker',
    path = 'Joker.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'Tarot',
    path = 'Tarot.png',
    px = 71,
    py = 95
}

-- jokers

SMODS.Joker{
    name = 'Stique',
    key = 'stique',
    loc_txt = {
        name = 'Stique',
        text = {
            'Gain {X:red,C:white}X#2#{} Mult when {C:attention}Blind{} selected',
            '{C:green}#3# in #4#{} chance this card is destroyed',
            '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}',
            '',
            '{C:inactive}Stique is one of the best players when{}',
            '{C:inactive}he plays legitimately, but has been exposed{}',
            '{C:inactive}for cheating three separate times.{}'
        },  
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
			Xmult = 1,
            mult_gain = 1,
            numerator = 1,
            denominator = 4
        }
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'Joker',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult, card.ability.extra.mult_gain, card.ability.extra.numerator, card.ability.extra.denominator}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return{
                xmult = card.ability.extra.Xmult
            }
        end
        if context.setting_blind then
            if SMODS.pseudorandom_probability(card, 'stique_destroy', card.ability.extra.numerator, card.ability.extra.denominator) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Exposed!'
                }
            else
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.mult_gain
            end
        end
    end
}

SMODS.Joker{
    name = 'mk',
    key = 'mk',
    loc_txt = {
        name = 'mk',
        text = {
            '{C:red}+#1#{} Mult if played hand is a valid',
            'US area code',
            '',
            '{C:inactive}mk knows a lot of area codes for{}',
            "{C:inactive}various countries, but isn't great{}",
            '{C:inactive}at pinpointing, making him unique{}',
            '{C:inactive}among moving players{}'
        },  
    },
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = {
			mult = 25
        }
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Joker',
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local hand_number = ""
            for i = 1, #context.full_hand do
                hand_number = hand_number .. tostring(context.full_hand[i]:get_id())
            end
            -- I don't know anything about lua I just like balatro. I'm really sorry about this table. At least I'm not using jokerforge. 
            local codes = {205,251,256,334,659,938,907,480,520,602,623,928,327,479,501,870,209,213,279,310,323,341,350,369,408,415,424,442,510,
            530,559,562,619,626,628,650,657,661,669,707,714,747,760,805,818,820,831,840,858,909,916,925,949,951,303,719,720,970,983,203,475,860,
            959,302,239,305,321,324,352,386,407,448,561,645,656,689,727,728,754,772,786,813,850,863,904,941,954,229,404,470,478,678,706,762,770,
            912,943,808,208,986,217,224,309,312,331,447,464,618,630,708,730,773,779,815,847,861,872,219,260,317,463,574,765,812,930,319,515,563,
            641,712,316,620,785,913,270,364,502,606,859,225,318,337,504,985,207,227,240,301,410,443,667,339,351,413,508,617,774,781,857,978,231,
            248,269,313,517,586,616,734,810,906,947,989,218,320,507,612,651,763,952,228,601,662,769,235,314,417,557,573,636,660,816,975,406,308,
            402,531,702,725,775,603,201,551,609,640,732,848,856,862,908,973,505,575,212,315,329,332,347,363,516,518,585,607,624,631,646,680,716,
            718,838,845,914,917,929,934,252,336,472,704,743,828,910,919,980,984,701,216,220,234,283,326,330,380,419,436,440,513,567,614,740,937,
            405,539,572,580,918,458,503,541,971,215,223,267,272,412,445,484,570,582,610,717,724,814,835,878,401,803,839,843,854,864,605,423,615,
            629,731,865,901,931,210,214,254,281,325,346,361,409,430,432,469,512,682,713,726,737,806,817,830,832,903,915,936,940,945,956,972,979,
            385,435,801,802,276,434,540,571,686,703,757,804,826,948,206,253,360,425,509,564,202,771,304,681,262,274,353,414,534,608,715,920,307}
            local pass = false
            for _, code in ipairs(codes) do
                if hand_number == tostring(code) then
                    pass = true
                    break
                end
            end
            print(tostring(pass))
            if pass then
                return{
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}

-- tarots

SMODS.Consumable{
    key = 'json',
    set = 'Tarot',
    atlas = 'Tarot',
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "Close the JSON",
        text = {
            "Shows what the next {C:attention}#1#{} cards in your deck are",
            "",
            "{C:inactive}It's complicated... essentially means 'stop{}",
            "{C:inactive}cheating with a file that tells you where{}",
            "{C:inactive}certain things are', so this tells you what{}",
            "{C:inactive}your cards are{}"
        }
    },
    config = {
        extra = {
            cards = 4
        }
    },
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.cards}}
    end,
    can_use = function(self, card)
        if G and G.deck then
            -- if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
            return true
            end
        -- end
        return false
    end,
    use = function(self,card,area,copier)
        for i = 1, math.min(card.ability.extra.cards, #G.deck.cards) do
            local i_card = G.deck.cards[#G.deck.cards - (i-1)]
            print(next(SMODS.get_enhancements(i_card)))
            local card_text = i_card:get_id() .. " of " .. i_card.base.suit .. ""
            if next(SMODS.get_enhancements(i_card)) then
                card_text = card_text .. "(" .. next(SMODS.get_enhancements(i_card)) .. ")"
            end
            G.E_MANAGER:add_event(Event({
                func = function()  
                    card_eval_status_text(card,'extra',nil,nil,nil,{message = card_text})
                    return true
                end,
                }))
        end
    end
}