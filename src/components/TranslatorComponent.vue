<template>
    <div>
        <h1>Welcome traveler, what would you like translated?</h1>
        <img @click="translate()" src="../assets/wizard.webp" alt="">
        <select id="languageSelect" class="interactField" v-model="targetLanguage">
            <option value="">Choose language to translate to</option>
            <option v-for="choice in languages" :key="choice.code" :value="choice.code">{{choice.name}}</option></select>
        <div id="textBoxWrapper">
            <textarea class="interactField" placeholder="Enter text you would like translated, here" v-model="userText"></textarea>
            <textarea class="interactField" placeholder="Translated Text" v-model="translatedText" disabled></textarea>  
        </div>
        <button @click="translate()">Translate</button>
    </div>
</template>

<script>
    import axios from "axios";
    export default {
        name:"TranslatorComponent", 
        data(){
            return{
                userText:"",
                translatedText:"",
                languages:[],
                targetLanguage:""
            };
        },
        created(){
            this.getLanguages()
        },
        methods:{
            async translate(){
                console.log (this.targetLanguage)
                const payload =
                    {
                        q:this.userText,
                        source:"auto",
                        target:this.targetLanguage,
                        format:"text",
                        api_key:import.meta.env.VITE_LIBRE_TRANSLATE_API_KEY

                    };
                
                try{
                    const response = await axios.post("https://libretranslate.com/translate", payload)
                    this.translatedText = response.data.translatedText
                }
                catch(error){
                    alert("Something hecked up, man");
                }
            },
            async getLanguages(){
                try{
                    const response = await axios.get("https://libretranslate.com/languages")
                    this.languages = response.data
                }
                catch(error){
                    alert("Are you serious, bruh?")
                }
            }
        }
    }
</script>

<style>
    h1 {
        color: white;
    }
    body{
        background-color: teal;
    }
    img {
        border-style: double;
        border-width: 5px;
        border-color: tan;
        margin-bottom: 20px;
        cursor: pointer;
    }
    .interactField{
        border: double 5px tan;
        width: 45%;
        background-color: black;
        color: white;
        height: 60px;
        margin: auto;
        font-size: 18px;
    }
    #languageSelect{
        width: 50%;
        height: auto;
        margin-bottom: 10px;
    }
    button {
        color: black;
        background-color: tan;
        border-radius: 5px;
        display: block;
        margin: auto;
        margin-top: 10px;
        font-size: 25px;
    }
    #textBoxWrapper{
        display: flex;
        
    }
</style>