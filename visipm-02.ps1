$SSE_ITEM_TYPES = @{
    'AMMO' = 'Ammo';
    'ARMO' = 'Armor';
    'BOOK' = 'Book';
    'ALCH' = 'AlchemyItem';
    'INGR' = 'Ingredient';
    'KEYM' = 'Key';
    'LIGH' = 'Light';
    'MGEF' = 'MagicEffect';
    'MESG' = 'MESG'; #?
    'MISC' = 'Misc';
    'SCRL' = 'Scroll';
    'SHOU' = 'SHOU'; #?
    'SLGM' = 'SoulGem';
    'SPEL' = 'Spell';
    'WEAP' = 'Weapon'
}

ls '*-sseedit-messages.txt' | %{
    cat "$_" | ? {"$_" -like 'Processing:  \ *' } | %{
        $parts = "$_" -split '\] GRUP Top "'
        $groupP = $parts[1] -split '" \\ \['

        $slugPx1 = $groupP[1] -split ' "'
        $slugPx2 = $slugPx1[0] -split '\] '

        $idP = $slugPx1[1] -split '" \['
        $idP2 = $idP[1] -split ':'
        $idP3 = $idP2[1] -split '\]'

        $id = $idP3[0]
        if ($id -like '02*') {
            $id = "$($id -replace '^02','0x')~Dawnguard.esm"        
        } elseif ($id -like '03*') {
            $id = "$($id -replace '^03','0x')~HearthFires.esm"        
        } elseif ($id -like '04*') {
            $id = "$($id -replace '^04','0x')~Dragonborn.esm"        
        } elseif ($id -like '07*') {
            $id = "$($id -replace '^07','0x')~unofficial skyrim special edition patch.esp"        
        } else {
            $id = $id -replace '^00','0x'
        }

        echo "[$($SSE_ITEM_TYPES[$groupP[0]]).$($slugPx2[1])]"
        echo "Forms = $id"
        echo "Name = $($idP[0])"
        echo ""
    } | out-file -encoding utf8 "${_}_IPM.ini"
}
