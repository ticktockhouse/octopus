BASE_URL="https://api.octopus.energy"
PRODUCT_CODE="AGILE-18-02-21"
TARIFF_CODE="E-1R-"$PRODUCT_CODE"-C"
TARIFF_URL=""$BASE_URL"/v1/products/"$PRODUCT_CODE"/electricity-tariffs/"$TARIFF_CODE""

# SECRET VARS
#OCTOPUS_API_KEY=$(pass show octopus/api-key)
#MPAN=$(pass show octopus/elec-mpan)
#SERIAL=$(pass show octopus/elec-serial)

# OTHER VARS
TIME=$(date +%s)
TIME_HALF_HOUR=$(("$TIME" - ("$TIME" % (30 * 60))))
TIME_NEXT_HALF_HOUR=$(("$TIME" + 1800 - ("$TIME" % (30 * 60))))
TIME_NEXT_HOUR=$(("$TIME" + 3600 - ("$TIME" % (30 * 60))))
TIME_LAST_HALF_HOUR=$(("$TIME" - 1800 - ("$TIME" % (30 * 60))))
DATE_HALF_HOUR=$(date -d @"$TIME_HALF_HOUR" -Iseconds)
DATE_NEXT_HALF_HOUR=$(date -d @"$TIME_NEXT_HALF_HOUR" -Iseconds)
DATE_LAST_HALF_HOUR=$(date -d @"$TIME_LAST_HALF_HOUR" -Iseconds)
DATE_NEXT_HOUR=$(date -d @"$TIME_NEXT_HOUR" -Iseconds)

UNIT_PRICE_NOW=$(http "$TARIFF_URL"/standard-unit-rates/ period_from=="$DATE_HALF_HOUR" period_to=="$DATE_NEXT_HALF_HOUR" | jq .results[].value_inc_vat)
UNIT_PRICE_THEN=$(http "$TARIFF_URL"/standard-unit-rates/ period_from=="$DATE_LAST_HALF_HOUR" period_to=="$DATE_HALF_HOUR" | jq .results[].value_inc_vat)
UNIT_PRICE_NEXT=$(http "$TARIFF_URL"/standard-unit-rates/ period_from=="$DATE_NEXT_HALF_HOUR" period_to=="$DATE_NEXT_HOUR" | jq .results[].value_inc_vat)


echo "Electricity price right now is "$UNIT_PRICE_NOW"p/kWh"
echo "Electricity price last half hour was "$UNIT_PRICE_THEN"p/kWh"
echo "Electricity price next half hour will be "$UNIT_PRICE_NEXT"p/kWh"
