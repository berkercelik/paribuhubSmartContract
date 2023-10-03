// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract KiralamaKontrati {
    address public evSahibi;
    
    struct Kiraci {
        string ad;
        string adres;
    }
    
    struct Mekan {
        string adres;
        uint256 kiraBaslangic;
        uint256 kiraBitis;
        string kiraciYorumlari;
    }
    
    mapping(address => Kiraci) public kiracilar; //kiracilari cagirir
    mapping(address => Mekan) public kiradakiMekanlar; //kiradaki mekanlari cagirir

    event MekanKiralandi(address indexed kiraciAdres, string mekanAdres); //kiralama eventi ve parametreleri
    event KiralamaSonlandirildi(address indexed kiraciAdres, string mekanAdres); //kira sonlandirma eventi ve parametreleri
    
    constructor() { 
        evSahibi = msg.sender; //kurucu cuzdanin adresi
    }
    
    //evsahibi cuzdanin kontrol edilmesi
    modifier kontrolEvSahibi() {
        require(msg.sender == evSahibi, "Sadece ev sahibi bu islemi gerceklestirebilir.");
        _;
    }
    
    //kiralama fonksiyonu
    function mekanKirala(string memory kiraciAd, string memory kiraciAdres, string memory mekanAdres, uint256 kiraBaslangic, uint256 kiraBitis, string memory kiraciYorumlari) external {
        require(bytes(kiraciAd).length > 0, "Kiraci adi bos olamaz.");
        require(bytes(kiraciAdres).length > 0, "Kiraci adresi bos olamaz.");
        require(bytes(mekanAdres).length > 0, "Mekan adresi bos olamaz.");
        require(kiraBaslangic < kiraBitis, "Kira baslangic tarihi, kira bitis tarihinden sonra olmalidir.");
        
        Kiraci storage kiraci = kiracilar[msg.sender];
        kiraci.ad = kiraciAd;
        kiraci.adres = kiraciAdres;
        
        Mekan storage mekan = kiradakiMekanlar[msg.sender];
        mekan.adres = mekanAdres;
        mekan.kiraBaslangic = kiraBaslangic;
        mekan.kiraBitis = kiraBitis;
        mekan.kiraciYorumlari = kiraciYorumlari;
        
        emit MekanKiralandi(msg.sender, mekanAdres);
    }
    

    //kira sonlandirma fonksiyonu
    function kiralamaSonlandir(string memory mekanAdres) external kontrolEvSahibi {
        delete kiracilar[msg.sender];
        delete kiradakiMekanlar[msg.sender];
        
        emit KiralamaSonlandirildi(msg.sender, mekanAdres);
    }
}